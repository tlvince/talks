---
title: How we devop
author: \@tlvince
date: 2017-10-16
---

# Static web apps

## Common case

* Most apps are Progressive Web Apps
    * "No server needed"
* Scaffolds come with their own build chain
    * Use Create React App unless you have a good reason not to

## CI/CD

* TravisCI (pro); primarily Continuous Integration
    * Default: `script: npm test`
    * Therefore, run `build` `after_success`
* TravisCI can do CD: Continuous ~~Deployment~~ Delivery
    * Multiple providers; mostly concerned with S3
    
## S3

* Main origin
* Use DNS-compliant names; `-` seperated, not `.`
* TravisCI [can’t currently][traviscache] set caching headers per-file
    * Use [awss3-deploy][]
* [conditional-travis-deploy][] used determine environment/build type, "triggers"
    
[traviscache]: https://github.com/travis-ci/dpl/pull/170
[awss3-deploy]: https://github.com/tlvince/awss3-deploy
[conditional-travis-deploy]: https://github.com/tlvince/conditional-travis-deploy

## CloudFront

* CDN
* S3 can't serve SSL/custom domains
* Have to be careful with caching headers
    * Set `no-cache` on `index.html`, rev everything else
    
## CloudFlare

* CDN, but also happens to provide a nice distributed DNS with an API
    * Make sure to disable it's CDN (orange cloud icon)
* CNAME subdomain `[env].[app].[domain].[tld]` to CloudFront URL

## LetsEncrypt

* Free SSL certificates
* Currently issuing cert per app
* Automate proof of domain ownership via dehdrate + lexicon

## Backups

* Archive and hot swap via awss3-deploy
* Bucket retention & rotation rules
* Rollback via directory switching
    * Not had to thus far

## Monitoring

* AWS health check
* Uptimerobot (availability/ping metrics)
* `ssl-check`

## Risks

* AWS reliance
    * S3 outage

## Alternatives

* Surge
* Netlify
* GitHub pages
