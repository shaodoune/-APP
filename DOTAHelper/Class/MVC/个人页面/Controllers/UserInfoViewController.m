//
//  UserInfoViewController.m
//  DOTAHelper
//
//  Created by 千锋 on 16/1/11.
//  Copyright © 2016年 abc. All rights reserved.
//

#import "UserInfoViewController.h"
#import "VerifyPhoneViewController.h"

typedef NS_ENUM(NSInteger, choosePhotoType)
{
    choosePhotoTypeAlbum,
    choosePhotoTypeCamera
};

@interface UserInfoViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *userIcon;



@property (nonatomic, assign) BOOL isPhoneVerfied;


@end

@implementation UserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self refreshUserInfo];
    [self addScaleView];
    self.navigationController.navigationBar.translucent = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addScaleView
{
    [self.tableView addScaleImageViewWithImage:[UIImage imageNamed:@"dota_gqtp2"]];
}


- (void)dealloc
{
    [self.tableView removeScaleImageView];
    [self.tableView removeFromSuperview];

}

-(void)refreshUserInfo
{
    BmobUser * user = [BmobUser getCurrentUser];
    NSString * urlStr = [user objectForKey:@"userIconUrl"];
    
    BOOL isPhoneNumberVerified = [[user objectForKey:@"mobilePhoneNumberVerified" ] boolValue];
    
    if (isPhoneNumberVerified) {
        NSIndexPath * indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        UITableViewCell * cell = [self.tableView cellForRowAtIndexPath:indexPath];
        cell.textLabel.text = @"手机号已验证";
        _isPhoneVerfied = YES;
    }
    
    else
    {
        NSIndexPath * indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        UITableViewCell * cell = [self.tableView cellForRowAtIndexPath:indexPath];
        cell.textLabel.text = @"验证手机号";
        _isPhoneVerfied = NO;
    }
    
    [self.userIcon sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"avatar_default_big"]];
}
- (IBAction)userIconTap:(UITapGestureRecognizer *)sender {
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"选择相片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction * album = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self choosePhoto:choosePhotoTypeAlbum];
    }];
    
    UIAlertAction * camera = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self choosePhoto:choosePhotoTypeCamera];
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }];
    [alert addAction:album];
    [alert addAction:camera];
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:nil];

}

-(void)choosePhoto:(choosePhotoType)type
{
    UIImagePickerController * picker = [[UIImagePickerController alloc]init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    if (type == choosePhotoTypeAlbum) {
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    else if (type == choosePhotoTypeCamera)
    {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        }
        else
        {
            [SVProgressHUD showErrorWithStatus:@"相机不可用"];
            return;
        }
    }
    
    [self presentViewController:picker animated:YES completion:nil];
}
- (IBAction)loginout:(UIButton *)sender {
    
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否要退出登录?" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * canncel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
        UIAlertAction * quit = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [BmobUser logout];
            [[NSNotificationCenter defaultCenter]postNotificationName:USER_REFRESH_NOTICE object:nil];
            [self refreshUserInfo];
        }];
    
        [alert addAction:canncel];
        [alert addAction:quit];
    
        [self presentViewController:alert animated:YES completion:nil];
}

#pragma  mark - UITableViewDelegate/Datasource

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (_isPhoneVerfied) {
        return;
    }
    
    switch (indexPath.row) {
        case 0:
        {
            VerifyPhoneViewController * vpVC = [self.storyboard instantiateViewControllerWithIdentifier:@"VerifyPhoneViewController"];
            vpVC.pbBlock = ^{
                NSIndexPath * indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
                UITableViewCell * cell = [self.tableView cellForRowAtIndexPath:indexPath];
                cell.textLabel.text = @"手机号已验证";
                _isPhoneVerfied = YES;
            };
            [self.navigationController pushViewController:vpVC animated:YES];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - 选择图片

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage * img = info[UIImagePickerControllerEditedImage];
    NSData * imgData = nil;
    
    if (UIImagePNGRepresentation(img)) {
        imgData = UIImagePNGRepresentation(img);
    }
    else if(UIImageJPEGRepresentation(img, 1))
    {
        imgData = UIImageJPEGRepresentation(img, 1);
    }
    
    imgData = UIImageJPEGRepresentation(img, 0.1);
    
    UIImage * theImg = [self zipImageWithData:imgData limitedWith:140];
    
    [picker dismissViewControllerAnimated:YES completion:^{
        [self uploadImageWithImage:theImg];
    }];
}

-(UIImage *)zipImageWithData:(NSData *)imgData limitedWith:(CGFloat)width
{
    UIImage * img = [UIImage imageWithData:imgData];
    
    CGSize oldImgSize = img.size;
    
    if (width > oldImgSize.width) {
        width = oldImgSize.width;
    }
    
    CGFloat newHeight = oldImgSize.height * ((CGFloat)width / oldImgSize.width);
    
    CGSize size = CGSizeMake(width, newHeight);
    
    UIGraphicsBeginImageContext(size);
    
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage * newImg = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImg;
}

-(void)uploadImageWithImage:(UIImage *)img
{
    NSData * data = UIImagePNGRepresentation(img);
    
    [SVProgressHUD showWithStatus:@"上传图片..." maskType:SVProgressHUDMaskTypeClear];
    
    [BmobProFile uploadFileWithFilename:@"用户图标" fileData:data block:^(BOOL isSuccessful, NSError *error, NSString *filename, NSString *url, BmobFile *file) {
        if (isSuccessful) {
            BmobUser * user = [BmobUser getCurrentUser];
            [user setObject:file.url forKey:@"userIconUrl"];
            
            [user updateInBackgroundWithResultBlock:^(BOOL isSuc, NSError *err) {
                if (isSuc) {
                    [SVProgressHUD showSuccessWithStatus:@"上传成功"];
                    
                    [BmobImage cutImageBySpecifiesTheWidth:100 height:100 quality:50 sourceImageUrl:file.url outputType:kBmobImageOutputBmobFile resultBlock:^(id object, NSError *error) {
                        BmobFile * resFile = object;
                        NSString * resUrl = resFile.url;
                        
                        [self.userIcon  sd_setImageWithURL:[NSURL URLWithString:resUrl]];
                        [[NSNotificationCenter defaultCenter]postNotificationName:USER_REFRESH_NOTICE object:nil];
                        
                    }];
                }
                else
                {
                    [SVProgressHUD showErrorWithStatus:[err localizedDescription]];
                }
            }];
        }
        else
        {
            [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        }
    } progress: ^(CGFloat progress){
        [SVProgressHUD showProgress:progress];
    }];
}




-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}


@end
