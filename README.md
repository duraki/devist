[![Gem Version](https://badge.fury.io/rb/devist.svg)](https://badge.fury.io/rb/devist)
<p align="center"><img width="200px" src="docs/img/devist-trans.png"/></p>

# devist!
A Ruby gem to **export release notes based on your changelog file**.

  
## How do I devist?
Let's pretend you are a developer having typical `CHANGELOG.md`, `RELEASES.md`, `NEWS.md` in your project repository. 
Using **devist**, you can generate and export these notes to `.html` and allow users to check them out without reading 
 ugly markdown format.
 
The only thing you have to do is run `devist filename` command inside your project directory. **devist** will look for the 
given file and export beautiful HTML page of release notes.
  


**Install Devist**:

```
$ gem install devist
```

**Example**:

```
ruby bin/devist.rb changelog
         __          _      __ 
    ____/ /__ _   __(_)____/ /_
   / __  / _ \ | / / / ___/ __/
  / /_/ /  __/ |/ / (__  ) /_  
  \__,_/\___/|___/_/____/\__/ 
- Release notes generator.
  https://github.com/duraki/devist

  Use --help for details.

  * devist will try to generate export for file 'changelog' with theme 'default'
  * File 'changelog.md' exists; continuing ...
  * Theme '_default.html.erb' exists; continuing ...
  * Checking if changelog is devist configured ...
  * Found .devist signature.
  * Building model from file data ...
  * Extracting project name ... [devist]
  * Extracting project author ... [Halis Duraki <duraki.halis@nsoft.ba>]
  * Extracting project homepage ... [https://devist.io]
  * Found version 1.1.3; registered ...
  * Found version 1.1.2; registered ...
  * Found version 1.1.1; registered ...
  * Found version 1.1.0; registered ...
  * Found version 1.0.1; registered ...
  * Found version 1.0.0; registered ...
  -
  * Trying to compile set ...
  * Creating new export from erb ...
  * Injecting parsed results to the erb ...
  * Writing compiled data to changelog file ...
  -
  ** All done! Check changelog.html file in your browser :)
```
  
## Installation

### Automatic Installation
To install `devist`, run:

```
$ gem install devist
```

### Manual Installation
For nightly builts, you may want to clone or checkout the branch/nightly and build the gem from
`.*gemspec`.
  
```
$ git clone https://github.com/duraki/devist
$ cd devist && gem build devist
$ gem install ./devist
```

## General
Check [devist changelog](https://devist.io/changelog.html) for showoff. The `devist` is
built and debugged upon it's changelog file. Ain't that cool?
  
## Why is it useful?
Before **devist**, I made [vicilog](https://github.com/duraki/vicilog). Although it got attention on the original 
repository, the system was not dynamic, and very, very basic. You had to enter all changelogs in raw RIPL system and you 
couldn't reuse the `json` properly.
   
Devist allows a great number of options including but not limited to export theme, export method, ease of use and still getting updated.

Here are the main reason why you should use **devist**:

* The changelog format is properly examined to be readable as:
  - Textual document (raw text)
  - Markdown parsed (we followed GitHub style)
  - Devist exported (with any theme of your choice)
  - Inspired by keepachangelog
  
* Devist will sort your tags by priority in this order: **added**; **fixed**; **removed**; **improved**
  - We still allow theme contributors to reuse order of tags how ever they want (yayy!)
  
* Changelog `.md` format is easy to extend
  - You can use HTML directly
  - It's widely supported
  - It's readable and reusable
  
* Theme support
  - We got you covered with default themes (`default`, & `polar`)
  - You can write custom themes to fit your project design
  - Themes are easy to write! Check theme contribution in [CONTRIBUTION](CONTRIBUTION.md) for details or look into code of default themes.
  
* Export
  - The main point of **devist** is to keep changelog readable
    - *it does so by allowing you to export this notes in html*
  - The export file `changelog.html` is generated at project `.md` location
  - You can create a deploy task to generate + move the file to your controller action
  - [Integration](#integration)

* *More soon heh*

## Themes (+ contribution)
Refer to default themes in repository for contribution help and future documentation.
  
Easiest way to create theme is to bundle it in one static page, although you can extend it how ever
you want.  
  
Download themes to your `$HOME/.devist-themes/` or call `devist theme [raw]` where ever you want.
  
```sh
# Install manually

$ mkdir $HOME/.devist-themes
$ cd $HOME/.devist-themes
$ wget https://raw.githubusercontent.com/duraki/devist/master/lib/devist/export/html/_default.html.erb
```

```sh
# Install using devist bin

$ devist theme default https://raw.githubusercontent.com/duraki/devist/master/lib/devist/export/html/_default.html.erb

** Installing Devist theme to `$HOME/.devist-themes/` ...
```
  
The compiler build themes upon `*.erb` binding.
Currently, the project offers two built-in themes: **default**, & **polar**. 
  
If you want to **contribute** to themes, please, do so in [devist-themes](https://github.com/stacklog/devist-themes) repository. To learn how to make own themes, please refer to our API. For better understanding, read the code of built-in themes.

Here is small list of contribution guidelines regarding public themes:
  
* Your theme should do only one thing - show changelog / release notes
* If you want to publish the theme for public in our repository, that is awesome! 
* Theme authors are allowed. Props.
* The theme should follow the in-line and in-file style (no external stylesheets / JS / ads / tracking are allowed)
* Google Fonts is allowed
  
## Requirements
To run `devist` on your system you basically don't need anything. We followed best advice as with `vicilog` and made 
the **devist** be available in the wild without huge dependency list.

Since `devist` is built natively with Ruby components/libs, you can start using **devist** right now.

Check if your system does have at least Ruby 2.0.0 installed.

```
$ ruby -v
ruby 2.0.0p648 (.) 
```

Of course, your project should have `changelog.md` or equivalent so *devist* can parse and export something.

**You can install devist as you do with any other gem.** - `gem install devist`

## Changelog format
The changelog format we prefer is really easy to remember and understand under various circumstances. Please, use either 
`$ devist --new` to create a new base skeleton for the changelog file or create your sample like this:
  
```
$ devist --new
  --snip

  * Generating CHANGELOG.md ...
  * Output .devist as a way of thinkering ...
  -
  ** All done! Continue editing CHANGELOG.md.

$ cat CHANGELOG.md
@project: MyProject
@author: Your Name <email@address.com>
@homepage: https://example.com

### Version 1.0.0 of 20 Jul 2017
+ #added: something goes here

.devist
```
  
Basic requirements for the `changelog.md` file are these:
  
* There are optional `@project`, `@author`, and `@homepage` references
  - We advice you to use them and add two spaces after every line (line break) for readability
  
* To register a version, use `### Version x.x(.x) of Mon(th) dd YYYY`
  - Any date format is supported but keep it consistent
  
* To register a change, use `+ #[tag]: [change]`
  - Tags are: `added`, `fixed`, `removed`, `improved`
  - Example: + `#fixed: issue #39 - hell on earth`
  
* Last line of file can be anything, `.devist` is just a tag from us.  
  

# Integrations
  
## Deploy integration
One can use `devist` command on his pre-deploy stage to generate changelog on release. Example is presented below (pseudo on Mage configuration):

```
deploy:
  dev:
   - hostname
  pre-deploy:
   - devist changelog
   ...
  post-deploy:
   - mv changelog.html {your-app}/public/views/
```  

## Git integration
As of Devist v1.1.4, you can integrate a <pre-push> Git hook, located in `hook.sh` file in this
repository. The only thing you have to do is copy this file to your repository hooks. Example
follows as below.

```sh
# Integrate git-push hook
$ cd dev/your-project
$ cd .git/hooks/ && wget https://raw.githubusercontent.com/duraki/devist/master/hook.sh 
$ mv hook.sh pre-push && chmod +x pre-push
```
  
Once this **git hook** is added to your repository, you can't push a tag or release until you properly bumped the changelog version. 
To do so, the script goes through the file `CHANGELOG.md` before pushing the remote release, and check for a valid version. If current tag 
can't be located in that file, the script exit with error code registered by git and aborted. 

Example:  
```sh
$ (repo) $ git tag v2.1.1
$ (repo) $ git push origin v2.1.1
Devist / tag/hook / pre-push - https://devist.io
> Pre-push hook activated.
> Tag detected.
> Checking for file CHANGELOG.md in this directory ...
Checking tag version ...
Stripping non-numeric characters ...
Detected tag: 2.1.1
Checking latest TAG in changelog file ...
Tag not found in CHANGELOG.md ; please bump your version.
Use --no-verify while to skip this git-hook.
```
  
This is perfect solution if you don't want to push release without changelog bump. So, for above to works correctly, edit your logfile.
   
One can change default `CHANGELOG.md` filename to whatever his logfile name is. Make sure to only
edit `LOGFILE` variable inside the bash script.

In case you really don't care if CHANGELOG.md file consist of `HEAD` tag, you can use `--no-verify`
to skip the hook.
  
Example:
```
$ git tag v1.0.0
$ git push origin v1.0.0 --no-verify
```


## API
Refer to project [wiki](https://github.com/duraki/devist/wiki) for API documentation.

## Contribution
All contribution on **devist** project, **devist** themes, or overall code or documentation in general is highly appreciated.
Please refer to [CONTRIBUTION](CONTRIBUTION.md) file for more details.

## License
Devist is released under the [MIT License](http://www.opensource.org/licenses/MIT).

