# Development

Overcommit can be used to ensure that Conventional commits are good.

## Releases

```sh
# Update version.rb with the new version
# Update the gemfiles:
bin/appraisal
```

## Testing

```sh
# Running specs using a specific configuration:
bin/appraisal rails60-activeadmin22 rspec
# Using latest activeadmin version:
bin/appraisal rails60-activeadmin rspec
# See gemfiles for more configurations
```
