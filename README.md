# devist!

A Ruby library to create beautiful release notes.

## How do I devist?

Let's pretend you are a developer having typical `RELEASES.md`, `NEWS.md` or `CHANGELOG.md` in your project repository. 
Using **devist**, you can generate and export these notes to `.html` and allow users to check them out without reading 
 ugly markdown format.
 
The only thing you have to do is ran `devist filename` command inside your project directory. **devist** will look for the 
given file and export HTML page with default theme.
 
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
  * Extracting project homepage ... [https://duraki.gitlab.io]
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

In case `RELEASES.md` is not available in the directory, **devist** will search for `NEWS.md` and `CHANGELOG.md` 
respectively. We prefer to have our project root directory consist of `CHANGELOG.md` with necessary details.

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
* We sort your tags by priority in this order: **added**; **fixed**; **removed**; **improved**
  - That means any order of your `*.md` file tags will be properly parsed 
  - We still allow theme contributors to reuse order of tags how ever they want (yayy!)
* Changelog `.md` format is easy to extend
  - You can use HTML directly
  - It's widely supported
  - It's readable and reusable
* Theme support
  - We got default themes (`default`, `polar`)
  - You can write custom themes to fit your project webdesign
  - Themes are easy to write! Check [theme contribution](#theme contribution) for details.
* Export
  - The main point of **devist** is to export changelog in beautiful pages 
  - The export file `changelog.html` is generated at project `.md` location
  - You can create a deploy task to generate + move the file to your controller action
* More reasons coming soon! :)