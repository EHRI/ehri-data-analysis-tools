Extracting CSV data from the EHRI Search API
============================================

This tutorial shows you how to use some popular command-line tools
(available on MacOS, Linux, and Windows) to extract data from the 
EHRI Search API and convert it to CSV, where it can be imported into
Excel or a relational database. The tools we will be using are as 
follows:

 - [Curl](https://curl.haxx.se/) - a tool for making HTTP(S) requests from the command line
 - [Jq](https://stedolan.github.io/jq/) - a tool for processing and transforming JSON data in various ways

Both Curl and Jq are available on various platforms, but precise details of usage may vary
depending on the version and platform. This guide will assume you're using a system with a 
standard Unix-like shell (such as Bash), standard on MacOS or Linux and available on 
Windows in various forms such as [WSL](https://itsfoss.com/install-bash-on-windows/)
or [Git for Windows](https://gitforwindows.org/).

## The EHRI Search API

The EHRI Search API provides a way of retrieving information about items in the EHRI portal
in JSON (JavaScript Object Notation) format by making HTTP requests to particular URLs. Instead
of using a web browser to make web requests which return HTML pages, we're going to use a 
command line tool (CuRL) which fetches structured data we can then transform into CSV (comma
separated values), a format we can then import into a spreadsheet like Excel or Google Docs.

### Why JSON?

You might ask: why can't we just turn the HTML web page itself into a spreadsheet, or download 
a spreadsheet directly? Well, this is the so-called "web scraping" approach, and it's quite a 
common technique if the data is not accessible in other ways. The problem is that 
websites (including the EHRI portal) tend to be designed primarily to be rendered visually by 
a web browser, with the structure of the data being a secondary concern. Moreover, HTML is not
the easiest and most predictable format to transform into other formats and from which to extract
data. The EHRI Search API, on the other hand, is designed with this concern at the forefront.
While JSON cannot be loaded into a spreadsheet directly, it is arguably the most straightforward
and most commonly-used way of representing data that has more than one dimension, i.e. data that
would require potentially many separate and connected tables in a database to capture.

### API Documentation


The Search API has interactive documentation available at: https://portal.ehri-project.eu/api/v1

What's with the "/v1" bit in the URL?
####

This is there so if we decide to change the API in compatible ways in the future we can add a 
separte `/v2` URL and leave the old one in place. While the current `v1` API does change sometimes, 
we try not to change it in ways that could break existing usages.

## A note about Jq

For those of you familiar with UNIX tools like Awk, Jq will be familiar in as much as it is
really an entire programming environment hidden behind a fairly terse and cryptic command-line interface.
This means that some of the "recipes" below might seem a bit strange and byzantine if you're not
well acquainted with both Jq itself and the JSON format. Fear not: much like Awk, once a few idioms
are learned they can generally be easily adapted to handle a range of tasks with a bit of copy and paste.

For our tasks below we're going to be aiming to create CSV documents. Thankfully, Jq has some h
built-in functionality that makes this very easy, albeit in a way that only handles one specific
CSV dialect: fully-quoted cells with commas as the delimiter. For further processing of CSV documents
there are a range of separate utilities available: I use
[`csvtool`](http://manpages.ubuntu.com/manpages/bionic/man1/csvtool.1.html) but many others are available.

## A note about pagination

The EHRI Search API returns paginated responses of up to 20 items at a time. For datasets with more than
20 items we'll need to use some shell-scripting control flow to fetch the full set in one go.

## [Task 1: Fetching names and addresses of archival institutions](./task1.md)

