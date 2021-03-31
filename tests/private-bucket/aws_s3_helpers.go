package test

import (
	"fmt"
	"strings"
	"testing"

	"github.com/gruntwork-io/terratest/modules/aws"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func runAwsS3Localstack(t *testing.T) {
	t.Parallel()

	expectedName := fmt.Sprintf("s3-bucket-localstack-%s", strings.ToLower(random.UniqueId()))
	expectedACL := "private"

	// Pick a random AWS region to test in. This helps ensure your code works in all regions.
	awsRegion := aws.GetRandomStableRegion(t, nil, nil)

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "./",

		Vars: map[string]interface{}{
			"bucket_name": expectedName,
		},

		EnvVars: map[string]string{
			"AWS_DEFAULT_REGION": awsRegion,
		},
	})

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)

	bucketID := terraform.Output(t, terraformOptions, "this_s3_bucket_id")
	assert.Equal(t, expectedName, bucketID)

	bucketACL := terraform.Output(t, terraformOptions, "this_s3_bucket_acl")
	assert.Equal(t, expectedACL, bucketACL)

	bucketRegion := terraform.Output(t, terraformOptions, "this_s3_bucket_region")
	assert.Equal(t, "us-east-1", bucketRegion)

}
