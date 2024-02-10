## IAM

* subtitle-api-role: 
  Created an 'IAM Role' for 'EC2' with 'AmazonS3FullAccess'

* backend-role: 
  Created an 'IAM Role' for 'EC2' with 'AmazonS3FullAccess' and 'AmazonCognitoReadOnly'


## Security Group(sg) :
* lambda-subtitle-sg - To configure 'Inbound' or 'Outbound' rules. 
Configuration : 
    Type: Custom TCP
    Port range: 8080
    Destination: 'subtitle-api-sg'

* subtitle-api-sg - To allow access only from the '<lambda-caption-sg>'. 
Inbound Rules Configuration -
    Type: Custom TCP
    Port range: 8080
    Source: '<lambda-caption-sg>'

* frontend-sg - To allow 'HTTP' access from any address.
Inbound Rules Configuration - 
    Type: HTTP
    Source: Anywhere

* backend-sg- To allow access only from the '<frontend-sg>'
Inbound Rules Configuration -
    Type: Custom TCP
    Port range: 8080
    Source: Anywhere