# DOI

A Swift package for parsing DOIs into a type-safe struct.


## Installation

DOI is distributed with the [Swift Package Manager](https://swift.org/package-manager/). 
Add the following code to your `Package.swift` manifest.

``` Swift
let package = Package(
    ...
    dependencies: [
        .package(url: "https://github.com/iansampson/DOI", .branch("main"))
    ],
    ...
)
```

## Usage

You can construct a `DOI` using the standard prefix:

``` Swift
let doi = try DOI("doi:10.123/456")
```

Or with an URL path:

``` Swift
let doi = try DOI("https://doi.org/10.123/456")
```

You can access the registrant code and suffix as separate properties:

``` Swift
doi.registrantCode // 10.123
doi.suffix // 456
```

And you can reformat the DOI as an URL or a string:

``` Swift
doi.string // 10.123/456
doi.string(includingLabel: true) // doi:10.123/456
doi.url // https://doi.org/10.123/456
```
