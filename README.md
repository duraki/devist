# devist!
A Ruby library to **create beautiful release notes**.

## How do I devist?
Let's pretend you are a developer having typical `RELEASES.md`, `NEWS.md` or `CHANGELOG.md` in your project repository. 
Using **devist**, you can generate and export these notes to `.html` and allow users to check them out without reading 
 ugly markdown format.
 
The only thing you have to do is run `devist filename` command inside your project directory. **devist** will look for the 
given file and export beautiful HTML page of release notes.
 
```
ruby bin/devist.rb changelog
         __          _      __ 
    ____/ /__ _   __(_)____/ /_
   / __  / _ \ | / / / ___/ __/
  / /_/ /  __/ |/ / (__  ) /_  
  \__,_/\___/|___/_/____/\__/ 
- Release notes generator.
  https://github.com/stacklog/devist

  Use --help for details.

  * devist will try to generate export for file 'changelog' with theme 'default'
  * File 'changelog.md' exists; continuing ...
  * Theme '_default.html.erb' exists; continuing ...
  * Checking if changelog is devist configured ...
  * Found .devist signature.
  * Building model from file data ...
  * Extracting project name ... [devist]
  * Extracting project author ... [Halis Duraki <duraki.halis@nsoft.ba>]
  * Extracting project homepage ... [https://stacklog.github.io/devist]
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

Here is the example of **generated** `changelog.html` file with default theme:
<p align="center"><img src="http://i.imgur.com/ZdQ6sCE.png" height="500px"></p>

## Why is it useful?
Before **devist**, we developed [vicilog](https://github.com/stacklog/vicilog). Although it got attention on the original 
repository, the system was not dynamic, and very, very basic. You had to enter all changelogs in raw RIPL system and you 
couldn't reuse the `json` properly.
   
Devist allows a great number of options including but not limited to export theme, export method, ease of use, including 
new features coming soon.  

Here are the main reason why you should use **devist**:

* `.devist` changelog format is properly examined to be readable as:
  - Textual document (raw text)
  - Markdown parsed (we followed GitHub style)
  - Devist exported (with any theme of your choice)
* Devist will sort your tags by priority in this order: **added**; **fixed**; **removed**; **improved**
  - We still allow theme contributors to reuse order of tags how ever they want (yayy!)
* Changelog `.md` format is easy to extend
  - You can use HTML directly
  - It's widely supported
  - It's readable and reusable
* Theme support
  - We got you covered with default themes (`default`, `polar`, `vicilog`)
  - You can write custom themes to fit your project design
  - Themes are easy to write! Check theme contribution in [CONTRIBUTION](CONTRIBUTION.md) for details.
* Export
  - The main point of **devist** is to export changelog in beautiful pages 
  - The export file `changelog.html` is generated at project `.md` location
  - You can create a deploy task to generate + move the file to your controller action
* More reasons coming soon! :)

## Themes (+ contribution)
Refer to [devist-themes](https://github.com/stacklog/devist-themes) repository for themes contribution and documentation.

To install themes, just copy **_themename.html.erb** to your `devist` installation folder (usually `$HOME/devist/src/Export/html`).

Devist themes are developed by using standard API from compiled data. The compiler build themes upon `*.erb` binding.
Currently, the project offers three built-in themes: *default*, *polar*, and *vicilog*. 
  
If you want to **contribute** to themes, please, do so in [devist-themes](https://github.com/stacklog/devist-themes) repository.
To learn how to make own themes, please refer to our API. For better understanding, read the code of built-in themes.

Here is small list of contribution guidelines regarding themes:

* Your theme should do only one thing - show changelog / release notes
* If you want to publish the theme for public, please include `Created/Generated/Built with devist` 
* The theme should follow the in-line and in-file style (no external stylesheets / JS / ads / tracking)
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

## Changelog format
The changelog format we prefer is really easy to remember and understand under various circumstances. Please, use either 
`$ devist --new` to create a new base skeleton for the changelog file or create your sample like this:

```
@project: project    
@author: myusername <contact.me@mail.com>  
@homepage: https://github.com/project/repository  

### Version 1.0 of Mon(th) dd YYYY 
+ #added: default & polar theme

.devist
```

Basic requirements for the `changelog.md` file are these:
* There are optional `@project`, `@author`, and `@homepage` references
  - We advice you to use them and add two spaces after every line (line break)
* To register a version, use `### Version x.x(.x) of Mon(th) dd YYYY`
  - Any date format is supported but keep it consistent
* To register a change, use `+ #[tag]: [change]`
  - Tags are: `added`, `fixed`, `removed`, `improved`
* Last line of file **MUST** be `.devist` or compiler will fail 
  - This is to tell **devist** the file is configured for export

## Installation
Devist is in early stage so we didn't follow best pratice and build `gem` out of it. Instead, we built **devist** as a 
bin to be used as external devtool.

To install `devist`, run:

```
$ curl -sSL https://raw.githubusercontent.com/stacklog/devist/master/install.sh | sh
```

### Manual Installation
In case the `devist` installation script failed, please follow this to install manually.

```
# Replace .bashrc with your current shell dotfile 

$ cd && git clone https://github.com/stacklog/devist
$ echo "devist() { ruby $HOME/devist/src/bin/devist.rb \$1 \$2 }" >> $HOME/.bashrc
$ source .bashrc 
```

## API
Refer to project [wiki](https://github.com/stacklog/devist/wiki) for API documentation.

## Contribution
All contribution on **devist** project, **devist** themes, or overall code or documentation in general is highly appreciated.
Please refer to [CONTRIBUTION](CONTRIBUTION.md) file for more details.

## License
Devist is released under the [MIT License](http://www.opensource.org/licenses/MIT).

