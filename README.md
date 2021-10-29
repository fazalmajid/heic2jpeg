# heic2jpeg
Convert HEIC images to JPEG format on the Mac

A basic tool to convert Apple's obnoxious HEIC format images (as the default photo format for the iPhone or iPad camera) into proper cross-platform JPEGs. Since it uses Apple's CoreImage framework, you do not need to worry about infringing the many patents on this particularly encumbered format, as you are riding on Apple's license. The flip side is this will not run on Linux or other platforms.

## Usage

Running:

```
heic2jpeg foo.HEIC bar.HEIC ...
```

will convert `foo.HEIC` to `foo.jpg`, `bar.HEIC` to `bar.jpg` and so on. If the destination files already exist, they will *not* be overwritten. The only option is `--delete` to delete the HEIC file after successful conversion. The JPEG files will be created using 90% quality, which is more than good enough for smartphones with their low-quality sensors. Since it is using CoreImage, all the image metadata will be carried over, including iPhone geoloc data, so if you want to scrub that, you will need to use another tool like `jhead -purejpg` or my own [jpegstrip](https://blog.majid.info/trimming-the-fat-from-jpegs/).

To convert an entire directory with HEIC images, while using all the cores on my system, I use the command:

```
find $HOME/Pictures -name \*.HEIC -print0 | xargs -0 -P 12 -t -n 10 heic2jpeg
```

Where it will run 12 processes in parallel, consuming 10 files each. I find the optimal setting to be 150% to 200% of the actual cores on your system (not including Intel's fake Hyperthreading cores, which don't count).

## Building

You need to have Swift installed on your machine, e.g. by installing Xcode.

Then simply check out this repo, and inside it run `make`

## Note

This project has nothing to do with [github.com/crb912/heic2jpeg](https://github.com/crb912/heic2jpeg) other than sharing a name. That project is cross-platform, this tool only works on the Mac. Unfortunately, that project is also subject to patent issues. Just another reason to shun the HEIF/HEIC format.
