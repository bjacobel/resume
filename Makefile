CFDISTRO = E150AM6U5NAGG2

.DEFAULT_GOAL := default

default: tex upload invalidate

tex:
	mkdir -p build
	pdftex --output-directory=build resume.tex

upload:
	aws s3api put-object \
    --bucket files.bjacobel.com \
    --acl public-read \
    --content-type application/pdf \
    --key resume.pdf \
    --body build/resume.pdf

invalidate:
	aws configure set preview.cloudfront true
	aws cloudfront create-invalidation \
		--distribution-id $(CFDISTRO) \
    --paths /resume.pdf
