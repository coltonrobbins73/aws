# Create resources related to the data lake itself (e.g., S3 buckets)

resource "aws_s3_bucket" "raw_data" {
  bucket = "my-data-lake-raw"
}

resource "aws_s3_bucket" "processed_data" {
  bucket = "my-data-lake-processed"
}

# ... other data lake resources