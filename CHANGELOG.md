# 0.2.14
- prevent extract-device-id filter from grabbing /entities/ request
- remove masking of Valkyrie device level 403s

# 0.2.13
- use base Repose cookbook to add header-translation filter

# 0.2.12
- insert X-Repose-Forwarded-Host header into all requests

# 0.2.11
- grant pre-authorized to hybridRole in Valkyrie filter

# 0.2.10
- extend timeouts for Repose-origin connections to 60 seconds

# 0.2.9
- use only base url for identity
- ensure endpoint id is 'public_api'

# 0.2.8
- use node eth0 IP for ele environment

# 0.2.7
- pin version of repose (to the one that's not broken :wink:)
- replace boilerplate readme with something useful

# 0.2.6
- use direct path to java (now that it's fully consistent)

# 0.2.5
- specify arch for when kernel[:machine] is nil
- move custom bundle and jdk to cloud files

# 0.2.4
- updated jvm heap to 256/1024 (min/max)
- tweaked stage/prod credential handling
- added per-environment valkyrie url
- tossed some lint

# 0.2.3
- RC1 :)

# 0.1.0
- Initial release of wrapper-repose
