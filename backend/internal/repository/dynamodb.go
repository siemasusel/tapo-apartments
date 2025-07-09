package repository

import (
	"github.com/aws/aws-sdk-go-v2/service/dynamodb"
)

const tableName = "ApartmentsData"

type DynamoDB struct {
	client *dynamodb.Client
}

func NewDynamoDB(client *dynamodb.Client) *DynamoDB {
	return &DynamoDB{client}
}
