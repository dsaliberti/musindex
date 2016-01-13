#  🎧 musindex
An iOS app to search Itunes music.

## steps

✅ load Itunes feed;

✅ searchBar keyboard search button handler; 

✅ parse search result;

✅ tableView presents search results with thumbnails;

✅ search item detail with formatted informations and image;

## good to say

Universal app - use of autolayout promotes the support form iPhone 4s until iPad Pro;

Pure Objective-C with no libraries;

Quering and parsing in background thread;

Scrolls up after a second successful request;

## would be great

UnitTests
- model: should test the parsing process of the required data;
- viewModel: should test, inputing a mocked-model, expecting the ready-to-use data;
- viewController: should test if the given mocked-model is being displayed as expected;
