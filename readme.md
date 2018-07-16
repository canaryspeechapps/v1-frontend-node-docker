# notes

remember when you build your image for testing it should look something like this:

```
docker image build -t test .
```
the `-t` is for the tagname and 
obviously the `.` is for the docker image source 


# publishing

be sure to put the user image name in front of the docker image name

[user]/[image]

```
docker image push [image tag name]
```