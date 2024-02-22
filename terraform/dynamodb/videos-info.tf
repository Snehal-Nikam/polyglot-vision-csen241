provider "aws" {
  region = "us-west-1"  # Replace with your desired region
}

resource "aws_dynamodb_table" "videos" {
  name           = "videos-table"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "video_id"
  attribute {
    name = "video_id"
    type = "S"
  }
  attribute {
    name = "user_id"
    type = "S"
  }

  server_side_encryption {
    enabled = true
  }

  global_secondary_index {
    name               = "UserIdIndex"
    hash_key           = "user_id"
    projection_type    = "ALL"
    read_capacity      = 5
    write_capacity     = 5
  }

  ttl {
    attribute_name = "ttl"
    enabled        = true
  }

  point_in_time_recovery {
    enabled = true
  }

  tags = {
    Name        = "VideosTable"
    Environment = "Production"
  }
  
}