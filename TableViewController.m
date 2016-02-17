//
//  TableViewController.m
//  Test4
//
//  Created by Quazi Ridwan Hasib on 16/02/2016.
//  Copyright © 2016 Quazi Ridwan Hasib. All rights reserved.
//

#import "TableViewController.h"
#import "TableViewCell.h"

#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) //1
#define kLatestKivaLoansURL [NSURL URLWithString:@"http://api.kivaws.org/v1/loans/search.json?status=fundraising"]

@interface TableViewController ()
{
    NSArray* latestLoan;
    NSArray* latestLoan1;
    UIActivityIndicatorView *indicator;
}
@end


@implementation TableViewController

-(void)viewDidLoad
{
    NSLog(@"view loaded");
    
    //show loader vie
    indicator = [[UIActivityIndicatorView alloc]initWithFrame: CGRectMake(round((self.view.frame.size.width - 25) / 2), round((self.view.frame.size.height - 25) / 2), 25, 25)];
    //indicator.center = self.view.center;
    [indicator setBackgroundColor:[UIColor clearColor]];
    [indicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    [self.view addSubview:indicator];
    //[indicator release];
    
    
    [indicator startAnimating];

}

-(void)viewDidAppear:(BOOL)animated
{
    NSLog(@"view appear");
    
    
    NSError* error;
    NSData* data = [NSData dataWithContentsOfURL: kLatestKivaLoansURL];
    
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data
                                                         options:kNilOptions
                                                           error:&error];
    
    
    latestLoan = [json valueForKey:@"loans"];
    latestLoan1 = [latestLoan valueForKey:@"activity"];
    NSLog(@"id:%@",[latestLoan valueForKey:@"activity"]);
    
    //NSLog(@"aasd: %@", [latestLoan1 objectAtIndex:0]);
    
    [self.tableView reloadData];
    
    
}

#pragma mark - table methods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return latestLoan.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *bildurl = @"http://quaziridwanhasib.com/Product/5.jpg";
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:bildurl]]];

    
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.tableViewLabel.text = [NSString stringWithFormat:@"%@",
                                [latestLoan1 objectAtIndex:indexPath.row]
                                ];
    cell.tableImages.image = image;
    
    [indicator stopAnimating];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
   // LoanModel* loan = _feed.loans[indexPath.row];
    
//    NSString* message = [NSString stringWithFormat:@"%@ from %@ needs a loan %@",
//                         loan.name, loan.location.country, loan.use
//                         ];
//    
//    
//    [HUD showAlertWithTitle:@"Loan details" text:message];
}

@end

