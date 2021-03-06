// Header
#import "SPDOffersViewController.h"

// Vendor
// Sponsorpay
#import "SPOffer.h"

// App classes
// Views
#import "SPTableViewCell.h"

@interface SPDOffersViewController ()

# pragma mark - Private properties

@property (nonatomic, copy, readwrite) NSArray *offersArray;

@end

@implementation SPDOffersViewController

#pragma mark - Designated initializer

- (instancetype)initWithOffers:(NSArray *)offers
{
  NSAssert(offers, @"Offers argument is mandatory.");
  
  self = [super initWithNibName:NSStringFromClass([self class]) bundle:nil];
  if (self) {
    self.offersArray = offers;
  }
  return self;
}

#pragma mark - Template methods (Disabled)

- (instancetype)init
{
  [self doesNotRecognizeSelector:_cmd];
  return nil;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
  [self doesNotRecognizeSelector:_cmd];
  return nil;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil
                         bundle:(NSBundle *)nibBundleOrNil
{
  [self doesNotRecognizeSelector:_cmd];
  return nil;
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
  numberOfRowsInSection:(NSInteger)section
{
	return [self.offersArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  // Dequeue cell
  NSString *reID = @"cell";
  SPTableViewCell *cell;
  cell = [tableView dequeueReusableCellWithIdentifier:reID];
  if (!cell) {
    NSBundle *bundle = [NSBundle mainBundle];
    NSArray *views = [bundle loadNibNamed:@"SPTableViewCell" owner:self options:nil];
    cell = [views objectAtIndex:0];
  }
  
  // Get matching offer
  SPOffer *offer = self.offersArray[indexPath.row];
  
  // Setup cell
  cell.titleLabel.text = offer.title;
  cell.detailLabel.text = offer.teaser;
  cell.badgeLabel.text = [offer.payout description];
  cell.thubnailView.imageURL = offer.thumbnailURL;
	
	return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView
  heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  // Get matching detail text
  SPOffer *offer = self.offersArray[indexPath.row];
  
  // Calculate row height
  NSString *text = offer.teaser;
  CGSize constraint = CGSizeMake(280.0f, MAXFLOAT);
  NSStringDrawingOptions options = (NSStringDrawingTruncatesLastVisibleLine|
                                    NSStringDrawingUsesLineFragmentOrigin);
  UIFont *font = [UIFont fontWithName:@"Helvetica" size:14.0];
  NSDictionary *attributes =
    @{@"NSFontAttributeName": font};
  CGRect labelRect = [text boundingRectWithSize:constraint
                                        options:options
                                     attributes:attributes
                                        context:nil];
  CGSize labelSize = labelRect.size;
  
  return labelSize.height + 40;
}

@end
