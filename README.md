[![Build Status](https://travis-ci.org/mmi-cookbooks/wrapper-repose.svg)](https://travis-ci.org/mmi-cookbooks/wrapper-repose)

# repose-wrapper-cookbook

TODO: Enter the cookbook description here.

## Supported Platforms

TODO: List your supported platforms.

## Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['repose-wrapper']['bacon']</tt></td>
    <td>Boolean</td>
    <td>whether to include bacon</td>
    <td><tt>true</tt></td>
  </tr>
</table>

## Usage

### repose-wrapper::default

Include `repose-wrapper` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[repose-wrapper::default]"
  ]
}
```

## License and Authors

Author:: Rackspace (<YOUR_EMAIL>)
