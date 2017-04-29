# devist!

A Ruby library to create beautiful release notes.

## How do I devist?

Let's pretend you are a developer having typical `RELEASES.md`, `NEWS.md` or `CHANGELOG.md` in your project repository. 
Using **devist**, you can generate and export these notes to `.html` and allow users to check them out without reading 
 ugly markdown format.
 
The only thing you have to do is ran `devist` command inside your project directory. **devist** will look for the 
`RELEASES.md` and export HTML page.
 
```
$ devist
       __          _      __ 
  ____/ /__ _   __(_)____/ /_
 / __  / _ \ | / / / ___/ __/
/ /_/ /  __/ |/ / (__  ) /_  
\__,_/\___/|___/_/____/\__/  
 - Release notes generator.
   stacklog/devist
   
[+] Found RELEASES.md
[+] Parsing the data ...
[+] DONE! ~

[+] Building ERB
[+] Exporting ...
[+] DONE! ~

[+] Export saved in devist/releases.html
```

In case `RELEASES.md` is not available in the directory, **devist** will search for `NEWS.md` and `CHANGELOG.md` 
respectively. We prefer to have our project root directory consist of `CHANGELOG.md` with necessary details.

## Why is it useful?

Before **devist**, we developed [vicilog](https://github.com/stacklog/vicilog). Although it got attention on the original 
repository, the system was not dynamic, and very, very basic.
 
Devist allows a great number of options including but not limited to export theme, export method, ease of use, including 
new features coming soon.  
