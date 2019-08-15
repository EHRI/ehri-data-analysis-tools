Task 2: Fetching the English-language information for Yad Vashem descriptions
=============================================================================

NB: This task builds on some of the Jq techniques that were covered in [task 1](./task1.md).

For this task we will use the API to find Yad Vashem archival descriptions matching the word "Terezin" and then extract
just the *English-language* fields for the description name and *scope and content*.

**Just a warning**: a quirk (some might say wart) of the V1 EHRI Search API is that it assumes that archival units are
multi-lingual and returns their data contained in a `descriptions` array, a description being an object containing data
in a particular language (even if there is just one language.) This means that if you *do* want data in just one language you have to filter the JSON response. We'll see how to do this with Jq below.

First, how do we search just a single archival institution?

The API has a `search-in` action which allows you to search "within" an entity specified via its ID. This entity could
be a country (whose "contents" are archival institutions), an institution (for archival units), or an archival units
itself if we're interested in its child items.

In this case we're searching an archival institution -- Yad Vashem -- whose EHRI ID is `il-002798`.

This means the basic URL for searching inside YV is:

```bash
curl https://portal.ehri-project.eu/api/v1/il002798/search | jq .
```

Run that command and the response will look something like this (abbreviated):

```json
{
  "data": [
    {
      "id": "il-002798-4019608",
      "type": "DocumentaryUnit",
      "attributes": {
        "localId": "4019608",
        "alternateIds": [
          "P.19"
        ],
        "descriptions": [
          {
            "localId": "eng",
            "languageCode": "eng",
            "language": "English",
            "name": "The Carl Lutz Collection: Swiss Diplomat and Righteous Among the Nations, 1935-1970",
            "parallelFormsOfName": [],
            "extentAndMedium": "39 Files",
            "unitDates": [],
            "biographicalHistory": "Carl Lutz (1895-1975) was the Swiss Vice Consul in Jaffa, Eretz Israel, 1935-1941, and in Budapest, Hungary, 1942-1945.  Following the German occupation of Hungary, 1944, he was extremely active in rescuing Jews with United States, British, Romanian, El Salvadorian and other citizenships, as well as on behalf of those with certificates to make aliya to Eretz Israel. ",
            "archivalHistory": "The collection was submitted to Yad Vashem in 1981, through the generosity of Agnes Hirschi, Lutz's adopted daughter;",
            "scopeAndContent": "The collection is composed mainly of booklets written by Lutz... [ABBREVIATED]",
            "languageOfMaterials": [
              "German"
            ],
            "scriptOfMaterials": []
          },
          {
            "localId": "heb",
            "languageCode": "heb",
            "language": "Hebrew",
            "name": "P.19 - אוסף קרל לוץ (Carl Lutz), דיפלומט שוויצרי וחסיד אומות העולם, 1935- 1970",
            "parallelFormsOfName": [],
            "extentAndMedium": "נייר, 39 תיקים\r\n\r\nדוח-סקירה\r\n\r\nמכתב\r\n\r\nמחקר-מאמר\r\n\r\nתעוד-אישי\r\n\r\nרשימת שמות\r\n\r\nאלבום\r\n\r\nדרכון\r\n\r\nnewspaper clippings\r\n\r\nתצלום\r\n\r\nתעוד רשמי",
            "unitDates": [],
            "archivalHistory": "Agnes Hirschi\r\n\r\nהחומרים נמסרו ליד ושם על ידי בתו של קרל לוץ",
            "scopeAndContent": "אוסף קרל לוץ (Carl Lutz)... [ABBREVIATED]",
            "languageOfMaterials": [
              "German"
            ],
            "scriptOfMaterials": []
          }
        ]
      },
      "relationships": {
        "holder": {
          "data": {
            "id": "il-002798",
            "type": "Repository"
          }
        },
        "parent": null
      },
      "links": {
        "self": "https://portal.ehri-project.eu/api/v1/il-002798-4019608",
        "search": "https://portal.ehri-project.eu/api/v1/il-002798-4019608/search",
        "holder": "https://portal.ehri-project.eu/api/v1/il-002798"
      },
      "meta": {
        "subitems": 33,
        "updated": "2019-03-25T11:26:44.927Z"
      }
    },
    {"__COMMENT": "19 more items here"}
  ],
  "links": {
    "first": "https://portal.ehri-project.eu/api/v1/il-002798/search",
    "last": "https://portal.ehri-project.eu/api/v1/il-002798/search?page=289",
    "next": "https://portal.ehri-project.eu/api/v1/il-002798/search?page=2"
  },
  "included": [
    {
      "id": "il-002798",
      "type": "Repository",
      "attributes": {
        "name": "ארכיון יד ושם / Yad Vashem Archives",
        "parallelFormsOfName": [
          "YV Archives",
          "Yad Vashem Archives"
        ],
        "otherFormsOfName": [],
        "address": {
          "city": "Jerusalem",
          "country": "Israel",
          "countryCode": "IL",
          "email": [
            "ref@yadvashem.org.il"
          ],
          "telephone": [
            "+97226443669"
          ],
          "fax": [
            "9726443719"
          ],
          "url": [
            "http://yadvashem.org/"
          ]
        },
        "history": "In 1953... [ABBREVIATED]",
        "generalContext": "An Archive dedicated to the Holocaust in Europe",
        "holdings": "The Yad Vashem Archives holds... [ABBREVIATED]",
        "geo": {
          "type": "Point",
          "coordinates": [
            38.8677037219577,
            -89.8858402355004
          ]
        }
      },
      "relationships": {
        "country": {
          "data": {
            "id": "il",
            "type": "Country"
          }
        }
      },
      "links": {
        "self": "https://portal.ehri-project.eu/api/v1/il-002798",
        "search": "https://portal.ehri-project.eu/api/v1/il-002798/search",
        "country": "https://portal.ehri-project.eu/api/v1/il"
      },
      "meta": {
        "subitems": 196,
        "updated": "2018-07-09T11:19:48.513Z"
      }
    }
  ],
  "meta": {
    "total": 196,
    "pages": 10
  }
}
```

A few things to note about this (lengthy) response:

 - there are two items in the `descriptions` attribute, one in English (languageCode: eng) and another in Hebrew
   (languageCode: heb).
 - the response includes (in the "included" field) information about the Yad Vashem institution. 
   This is always the case when searching "inside" another record, but we can ignore it for now.

#### Adding a text query

In this case we don't want all items from Yad Vashem but just those that match the query "Terezin". We can a search
query by using the `q` parameter.

```bash
curl https://portal.ehri-project.eu/api/v1/il002798/search?q=Terezin | jq .
```

Instead of 196 items in 10 pages of results, we should now get around 13 items in one page of results.

We can get CSV of this data by using the following Jq program:

```bash
curl "https://portal.ehri-project.eu/api/v1/il-002798/search?q=Terezin&type=DocumentaryUnit" \
    | jq -r '.data[] 
                | .id as $id 
                | .attributes.descriptions[] 
                | [$id, .languageCode, .name, .scopeAndContent]
                | @csv'
```

This introduces another feature of Jq we haven't seen before: variables. The ID property of the record is on the main
object, but most of the data we want is per-description so we want to output one description per line. To be able to
refer back to the ID property when outputting the description data we store it (`.id as $id`) -- the variable indicated
by the sigil `$` -- and then refer to it later in the filter chain.

Notice how the filters read like:

 - for each object in the data array
 - save the ID as the `$id` variable
 - then for each object in the descriptions array
 - make an array of the `$id` variable, plus the language, name, and scopeAndContent properties
 - and convert it to CSV

#### Removing non-English descriptions

Finally, in this example we're only interesting in English-language descriptions. To filter out the Hebrew ones we can
simply use another Jq filter called `select`:

```bash
curl "https://portal.ehri-project.eu/api/v1/il-002798/search?q=Terezin&type=DocumentaryUnit" \
    | jq -r '.data[] 
                | .id as $id 
                | .attributes.descriptions[] 
                | select(.languageCode == "eng")
                | [$id, .languageCode, .name, .scopeAndContent]
                | @csv'
```

The `select` filter takes an expression and passes through incoming JSON for which that expression holds. Since the language code property is the bit we want to discriminate on, we want to check it matches the value "eng" which we do using the equality test operator `==`.

The result should be a nice list English-language description data.


