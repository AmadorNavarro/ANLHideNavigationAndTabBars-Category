ANLHideNavigationAndTabBar
==========================

A very ligth category of UIViewController that let hide the above and bellow bars when you use a UIScrollView subclass and dragging it.

![Example](http://ruralnerd.com/gitFtp/demoHideBars.gif)

##How to use it
Only import to your project ANLHideNavigationAndTabBar.h and .m and in your ViewController asing your UIScrollView subclass and enable the hidden flag, you can select the delay time in seconds to show the bars when the user end scroll. If you want disable the hide function, only set NO the hiddenEnable property.

**Enable**

	//Example
	-(void)viewWillAppear:(BOOL)animated {

    	[super viewWillAppear:animated];
    
    
    	[self setScrollViewInheritor:[self tableView]];
    	[self setHiddenEnable:YES];
    	[self setDuration:0];
	}

**Disable**

	[Self setHiddenEnable:NO];

You can change the delay when you want

**setNewDelay

	[self setDuration:3];

All feedback are wellcome.
