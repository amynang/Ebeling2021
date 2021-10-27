library(docxtractr)
library(tidyverse);library(reshape2)
library(glmmTMB)

#authors have helpfully split the necessary data to 3 different places:
#get the data from dryad
url = "https://datadryad.org/stash/downloads/file_stream/1071891"
data = read.csv(url, sep = ";")

#get MAT and MAP from supplement
url = "https://besjournals.onlinelibrary.wiley.com/action/downloadSupplement?doi=10.1111%2F1365-2745.13801&file=jec13801-sup-0001-Supinfo.docx"
docx = read_docx(url)
data2 = docx_extract_tbl(docx,
                         tbl_number = 1,
                         header = TRUE)
#get location-code to location index from txt 
url = "https://dryad-assetstore-merritt-west.s3.us-west-2.amazonaws.com/ark%3A/13030/m5w15m21%7C1%7Cproducer/Readme_LeafDamage_NutNet.txt?response-content-type=text%2Fplain&X-Amz-Security-Token=IQoJb3JpZ2luX2VjEPv%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEaCXVzLXdlc3QtMiJHMEUCIHkdgZETSG%2BogQ5dX%2FONv0Qwy2wgBr%2Bjb5PPNgUE0m2lAiEAuwIakyu11urNsMcPHckBux%2FJegsRbtkavTyRrAeLNVEqgwQIlP%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FARAAGgw0NTE4MjY5MTQxNTciDO%2Flkj2JUaU%2F4TJEzyrXA4cgjas16cCLcgoYw9pZzhjQkK9%2FiKfdeuYAlnnaxe6QH4jnFgStJ1M4gD0IvfFby65zlAunRnVJzclSp500P4c5G1R89etGbkUYjNmrD%2FoHpk3E3SXnKHR%2BXa9E1Gdpe8x9rHq15m0FaV%2FRbIXJ7LOHUt5zAZDdL8ZThuph%2FwSPOrwlRaTrELqzN96SDrpVQJ615W4zFlRINxWEKzjX%2Bm94yhE91ayTcGyfsW1%2BNzTw9q80dA4pRG6fEFxsNDMycxqQ%2Bc8%2BGLPL8x84fPvXJGiU0nTsFS4fh8kaCaoznncw2VqsWpJ%2BVtlSEJoIGYSyMzVGruTQN83UOSCJaRkXAySm9f8m2tVF%2BFcHv%2BBOqxfPJ6YWiNIJLV00kZtzg%2FM2Jwwj7FHD8a%2BKKiWV%2FXQeNjuGxRXYnQd0q6CKnGv9dsZIF%2B1JAOm58JaYpeQHWbXSy3QQ6j8jhmtdW8zfqgb7s7Uns9duKvOKOqppag%2BduMctFgVByB%2BFHb9pH9MifIAllcw8XMhOD0bbdbAg9h6LZ6jNRx9rxKoXqsiYcsbVj8UN8UIRjesAZD4to9sVV5XCTi0ouKXsTP%2BYnSxOu0dow9ETegoEirTwrCMY%2BPyFjd30Udmq48CI6jDCyOaLBjqlAR9nGCHI%2B1rysoz1Vpj3ItdCdnQk%2FhVF5x97do%2FxDxiUJrZsLyO0%2FWVjRfSOFlqAGaiA7ooGS1oVW29t3l2%2F7fmy1%2FQA8iiguwwf7SUpMr2XPTqKQhrGMe1F%2B0RWHPz6D2ZWh4B51u6TI6f1PHxgyOUNeQcmwoqB1yfVboo3RgXxjRrw9b72yBW%2F2ma9Nd1J89n6NCujSu%2BnaPZf7e%2BBLzNGXM%2FU5Q%3D%3D&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20211027T195736Z&X-Amz-SignedHeaders=host&X-Amz-Expires=14400&X-Amz-Credential=ASIAWSMX3SNW4RCH5OYH%2F20211027%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Signature=8c279fff4e372764eb37c71b4eeb9b5b83e64704d65f3b6f5091a8dbf5d6dddb"
data3 = read.table(url, sep = "=",
                   skip = 117, nrows = 27)
