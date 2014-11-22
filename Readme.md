# Bamboozled

This fork of [Skookum/bamboozled](https://github.com/Skookum/bamboozled) includes the Login API from BambooHR.

# Usage:

```ruby
# Create the client:
auth = Bamboozled.auth('your_app_id')
response = auth.authenticate('subdomain', 'username', 'password')
```

> TIP! You'll need to get an app_id from bambooHR.

## License

MIT. See the [LICENSE](/LICENSE) file.
