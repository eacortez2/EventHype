# Objective-C client Library for encoding Videos with HeyWatch

## Install

heywatchAPI for Objective-C is available through [CocoaPods](http://cocoapods.org), to install
it simply add the following line to your Podfile:

``` language-ruby
pod "HeyWatch"
```

Run `pod install` to install the dependency.

## Submitting the job

Use the [API Request Builder](https://app.heywatch.com/job/new) to generate a config file that match your specific workflow.

Example of `heywatch.conf`:

``` language-hw
var s3 = s3://accesskey:secretkey@mybucket

set source  = http://yoursite.com/media/video.mp4
set webhook = http://mysite.com/webhook/heywatch

-> mp4  = $s3/videos/video.mp4
-> webm = $s3/videos/video.webm
-> jpg_300x = $s3/previews/thumbs_#num#.jpg, number=3
```

Here is the Objective-C code to submit the config file:

``` language-objc
#import "HeyWatch.h"

NSString *apiKey = @"api-key";

// Reading the config from the heywatch.conf file
NSString *filePath = [[NSBundle mainBundle] pathForResource:@"heywatch" ofType:@"conf"];
NSError *error;
NSString *config = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];

if(error) {
    NSLog(@"Error reading config file: %@", error.localizedDescription);
    return;
}

[HeyWatch submit:config withApiKey:apiKey complete:^(id job, NSError *error) {
    if([[job objectForKey:@"status"] isEqualToString:@"ok"]) {
        NSLog(@"ID: %@", [job objectForKey:@"id"]);
    } else {
        NSLog(@"Error (%@): %@", [job objectForKey:@"error_code"], [job objectForKey:@"message"]);
    }
}];
```

*Released under the [MIT license](http://www.opensource.org/licenses/mit-license.php).*

---

* HeyWatch website: http://www.heywatchencoding.com
* API documentation: http://www.heywatchencoding.com/docs
* Github: http://github.com/heywatch/heywatch_api-ruby
* Contact: [support@heywatch.com](mailto:support@heywatch.com)
* Twitter: [@heywatch](http://twitter.com/heywatch) / [@sadikzzz](http://twitter.com/sadikzzz)