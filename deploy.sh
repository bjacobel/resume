# Install and configure AWS CLI if it's not installed
command -v aws >/dev/null 2>&1 || { pip install awscli; aws configure }

# Current version of AWS CLI only has beta Cloudfront support
aws configure set preview.cloudfront true

# Replace file on S3
aws s3api put-object \
  --bucket files.bjacobel.com \
  --acl public-read \
  --content-type application/pdf \
  --key resume.pdf \
  --body resume.pdf

# Invalidate Cloudfront cache
aws cloudfront create-invalidation \
  --distribution-id E150AM6U5NAGG2 \
  --paths /resume.pdf
