## Development

### Dev setup

There are 2 ways to interact with this project:

1) Using Docker:

```sh
make up         # starts the dev services (optional env vars: RUBY / RAILS / ACTIVEADMIN)
make specs      # run the tests (after up)
make lint       # run the linters (after up)
make server     # run the server (after up)
make shell      # open a shell (after up)
make down       # cleanup (after up)

# Example using specific versions:
RUBY=3.2 RAILS=7.1 ACTIVEADMIN=3.2.0 make up
```

2) With a local setup:

```sh
# Dev setup (set the required envs):
source extra/dev_setup.sh
# Install dependencies:
bundle update
# Run server (or any command):
bin/rails s
# To try different versions of Rails/ActiveAdmin edit extra/dev_setup.sh
```

### Update the editor

- Update the CSS/JS editor assets:

```sh
wget "https://cdn.jsdelivr.net/npm/quill@2/dist/quill.snow.css" -O "app/assets/stylesheets/activeadmin/quill_editor/quill.snow.css"
wget "https://cdn.jsdelivr.net/npm/quill@2/dist/quill.bubble.css" -O "app/assets/stylesheets/activeadmin/quill_editor/quill.bubble.css"
wget "https://cdn.jsdelivr.net/npm/quill@2/dist/quill.core.css" -O "app/assets/stylesheets/activeadmin/quill_editor/quill.core.css"

wget "https://cdn.jsdelivr.net/npm/quill@2/dist/quill.js" -O "app/assets/javascripts/activeadmin/quill_editor/quill.js"
wget "https://cdn.jsdelivr.net/npm/quill@2/dist/quill.core.js" -O "app/assets/javascripts/activeadmin/quill_editor/quill.core.js"

wget "https://github.com/valentsea/quill2-image-uploader/raw/refs/heads/master/dist/quill.imageUploader.min.js" -O "app/assets/javascripts/activeadmin/quill.imageUploader.min.js"

wget "https://github.com/valentsea/quill2-image-uploader/raw/refs/heads/master/dist/quill.imageUploader.min.css" -O "app/assets/stylesheets/activeadmin/quill.imageUploader.min.css"
```

- Check the changes, most of them should be for updated files plus some new / removed file
