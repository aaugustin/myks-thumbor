# Personal Thumbor Server

## Use case

This server is designed for thumbnailing a set of photos stored in S3 with
[Thumbor](https://github.com/thumbor/thumbor).

It caches metadata and thumbnails in S3. It avoids storing of copy of original
images.

All reads and writes to S3 are performed with the same AWS user. This user needs
read-only access to the bucket storing the images and read/write access to the
other buckets.

All S3 buckets are expected to have ``private`` ACLs. The app that generate URLs
is in charge of performing access control.

A health check is available at Thumbor's default URL ``/healthcheck``.

## Configuration

* Thumbor
    * `SECURITY_KEY`: large random value shared with the app generating URLs.
* S3
    * `LOADER_BUCKET_NAME`: bucket where original images are stored
    * `STORAGE_BUCKET_NAME`: bucket for caching metadata
    * `RESULT_STORAGE_BUCKET_NAME`: bucket for caching thumbnails
* AWS
    * `AWS_REGION`
    * `AWS_ACCESS_KEY_ID`
    * `AWS_SECRET_ACCESS_KEY`

## Deployment

```
$ pip install -r requirements.txt
$ thumbor
```
