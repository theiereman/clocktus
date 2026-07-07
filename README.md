<p align="center">
    <picture>
      <source media="(prefers-color-scheme: dark)" srcset="public/logo_full_dark.png">
      <source media="(prefers-color-scheme: light)" srcset="public/logo_full.png">
      <img alt="Clocktus Logo" title="Clocktus Logo" src="public/logo_full.png">
    </picture>
</p>

<p align="center">
  <a href="./LICENSE"><img alt="Licence" src="https://img.shields.io/github/license/Ileriayo/markdown-badges?style=for-the-badge"></a>
  <img alt="Rails" src="https://img.shields.io/badge/rails-%23CC0000.svg?style=for-the-badge&logo=ruby-on-rails&logoColor=white">
  <img alt="Ruby" src="https://img.shields.io/badge/ruby-%23CC342D.svg?style=for-the-badge&logo=ruby&logoColor=white">
  <br/>
  <a href="https://github.com/theiereman/clocktus/actions/workflows/ci.yml"><img alt="CI" src="https://github.com/theiereman/clocktus/actions/workflows/ci.yml/badge.svg"></a>
  <a href="https://codecov.io/github/theiereman/clocktus"><img alt="codecov" src="https://codecov.io/github/theiereman/clocktus/graph/badge.svg?token=JYLHM1JC65"></a>
</p>

Clocktus is a deliberately simple time-tracking app that helps you keep an eye on how you spend your everyday life. Each time slot is represented by a block, making logging your activities fast and intuitive. Statistics give you instant feedback on what you've actually done throughout your days.

## Features

### Track your time spent during the day

Click on some buttons - _badadim-badaboum_ - your time is tracked.

![Activities view](public/activities_view.png)

### Watch your statistics

![Number of activities per category stat](public/stat_1.png)

![Activities over time](public/stat_2.png)

### Use the calendar view to get an overview

Know at a glance which day is fully completed or not. It took me some time, but I also added the view Excel time-trackers love, you know: **the one with the colored cells**.

![Calendar view](public/calendar_view.png)

### Setup your preferences to streamline the process

Settings reduced to the essential because who needs more? Actually, if you need more let me know by opening an issue ;

### Desktop first but mobile friendly

As a huge nerd, my time is mostly spent in front of my computer, so the main layout was obviously designed for that viewport. At the moment the layout is responsive to make the app usable on mobile, but I don't think it's ideal. In the future I'll consider developing some native iOS / Android apps.

## Privacy

User connection is made using a magic link (it sends the user a code via email, and the connection is then stored in the user session). No info other than your email is stored in the database.

### Even more privacy

If you don't want your email to be stored in the database you can use any kind of alias to connect to the app as long as you're able to get the emails that are sent to that address.

[More details about email aliases](https://proton.me/blog/what-is-email-alias)

## Warning about tracking

There are no cookies or other user profiling service. I made this app for me and figured some other people could benefit from it or would enjoy using it.

I only added [Plausible](https://plausible.io/) which is a privacy-friendly analytics service that I host on my own hardware. I added that because I find it cool to see where traffic comes from, that's all.

### Disable tracking the hard way

If it bothers you, it can be easily deactivated using an ad blocker like uBlock Origin or any equivalent. If it bothers more people, I'll consider adding an option directly in the app settings.

## Contributing

See [contributing guideline](CONTRIBUTING.md)

## Philosophy around that app

Please note that this app is deployed on a modest local home-server in a KVM on Proxmox. Performance will not be great, but should be sufficient to click on some buttons.

Also be warned, as this goes public it'll be prone to DDOS and any other kind of attack. As I have a real job and a life, I won't make this a priority, and if I don't notice it or someone tells me via email, the server could stay down for a while.

Once you're aware of that you can use that app as you like, for fun or trying to break it!

In the future, if some more users enjoy it I'll make it more robust for the sake of everyone.

## Bug report or feature request

If you encounter a bug or have a feature request, [send me an email](mailto:contact@clocktus.com), create an issue, or start a discussion thread. Please be as descriptive as possible by providing the most information you can, and ideally an example or a way to reproduce it.

## Code of conduct

Before contributing to this repository, please read the [code of conduct](code_of_conduct.md)
