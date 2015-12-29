EnvPane - An OS X preference pane for environment variables
===========================================================

<img src="http://diaryproducts.net/files/EnvPane.png" style="float:left"/> EnvPane is a preference pane for Mac OS X 10.8 (Mountain Lion) that lets you set environment variables for all programs in both graphical and terminal sessions.  Not only does it restore support for `~/.MacOSX/environment.plist` in Mountain Lion, it also publishes your changes to the environment immediately, without the need to log out and back in.  This works even for changes made by manually editing `~/.MacOSX/environment.plist`, not just changes made via the preference pane.


Download
--------

For convenience, the pre-built and code-signed binary of EnvPane can be [downloaded] [8] from my blog Diary Products. Alternatively you might want to grab the [source] [9] and [build it yourself] [11].

[8]: http://diaryproducts.net/files/EnvPane-0.3.dmg
[11]: #Building.from.source

<!-- break -->

Background
----------

Mac OS X releases prior to Mountain Lion (10.8) included support for `~/.MacOSX/environment.plist`, a file that contained session-global, per-user environment variables. Starting with Mountain Lion, support of this [well] [2] [documented] [1] and [popular] [3] mechanism was dropped without an official announcement or explanation by Apple. It may have been in [response] [4] to the Flashback trojan which used that file to inject itself into every process, but this is a wild guess, especially considering that there is a relatively easy workaround, as demonstrated by the existence of this utility.

EnvPane includes (and automatically installs) a `launchd` agent that runs 1) early after login and 2) whenever the `~/.MacOSX/environment.plist` changes. The agent reads `~/.MacOSX/environment.plist` and exports the environment variables from that file to the current user's `launchd` instance via the same API that is used by `launchctl setenv` and `launchctl unsetenv`.

TODO: Mention RCEnvironment

TODO: Mention /etc/launchd.conf and ~/.launchd.conf

[1]: http://developer.apple.com/library/mac/#/legacy/mac/library/qa/qa1067/_index.html
[2]: https://developer.apple.com/library/mac/#documentation/MacOSX/Conceptual/BPRuntimeConfig/Articles/EnvironmentVars.html
[3]: https://www.google.com/search?q="environment.plist"
[4]: http://support.apple.com/kb/TS4267?viewlocale=en_US


Requirements
------------

Mac OS X 10.8, Mountain Lion or higher.


Installation
------------

1. Download the binary package
2. Double-click `EnvPane.pref-pane` file
3. Choose _Install for this user only_

Do not use the _Install for all users_ option. See the [FAQ](#Install.for.all.users).


Usage
-----

When you open the _Environment Variables_ preference pane, you will see a simple two-column table that lists the environment variables from your `~/.MacOSX/environment.plist`. If that file doesn't exist, the table will be empty but the file will be created as soon as you you add an entry to the table. To add an environment variable by clicking the `+` button. Specifying the name the new variable, hit `TAB`  and specify the value. Hit Enter. To modify a variable, double-click its name or value. Make the desired changes and hit `Enter`. To delete an environment variable, 

Changes are effective immediately in all subsequently launched applications. There is no need to reboot or log out and back in. Running applications will [not be affected] (#Running.applications.are.not.affected) . You need to quit and relaunch the application, in order for your changes to take effect.


Uninstallation
--------------

1. Open _System Preferences_ 
2. Right click _Environment Variables_
3. Select _Remove Environment Variables Preference Pane_

The uninstallation should be clean. I went to great lengths in ensuring that removing the preference pane doesn't leave orphaned files on the system. The `~/.MacOSX/environment.plist` will not be removed.


Changelog
---------

### v0.4

Changed: Built against latest SDKs, frameworks, and launchd source
Changed: Built with latest Xcode
Fix: envlib_unsetenv() is invoked unnecessarily with empty string if environment is empty ([issue #3] [12])

### v0.3

Fix: Preference pane fails to load if ~/Library/LaunchAgents is missing ([issue #2] [11])

### v0.2

Fix: Preference pane fails to load if ~/.MacOSX or ~/.MacOSX/environment.plist are missing ([issue #1] [10]).

### v0.1.1

Improved documentation.

### v0.1

Initial release.

[10]: https://github.com/hschmidt/EnvPane/issues/1
[11]: https://github.com/hschmidt/EnvPane/issues/2
[12]: https://github.com/hschmidt/EnvPane/issues/3

Building from source <a id="Building.from.source"></a>
--------------------

### Requirements ###

* Mac OS X 10.8, Mountain Lion
* Xcode 4.5.x (I use 4.5.2)
* A copy of Apple's `launchd` source tree, available on [Apple Open Source] [1] under the Apache License 2.0. The current version of EnvPane was compiled against [launchd-442.26.2] [2]
* David Parsons' [Discount] [3] C library by for processing John Gruber's Markdown. Install the library as described on the project page. Using the default installation prefix of `/usr/local` is recommended. The current version of EnvPane was compiled against version 2.1.5a of the library.

[5]: http://www.opensource.apple.com/source/launchd/
[6]: http://www.opensource.apple.com/source/launchd/launchd-442.26.2/
[7]: http://www.pell.portland.or.us/~orc/Code/discount/

### Build ###

1. Clone the [EnvPane repository] [9] on Github
2. Open the Xcode project
3. At the project level, adjust the `launchd_source_dir` custom build setting to point to the copy of the launchd source tree
4. Build the project

[9]: https://github.com/hschmidt/EnvPane


FAQ
---
<a id="Install.for.all.users"></a>
### Why can't I install the preference pane for all users?
There are two reasons. The first one is a technicality: the environment variables configured via the preference pane are actually set by a launchd agent contained in the bundle. The agent uses launchd's `WatchPath` mechanism in order to be notified when the user's `~/.MacOSX/environment.plist` changes. Unfortunately, there is no way to specify a `WatchPath` that is relative to the user's home directory. By installing the EnvPane preference pane for individual users, each instance can use a separate copy of the agent configuration in `~/Library/LaunchAgents` as opposed to globally in `/Library/LaunchAgents`.
The second reason is that cleanly uninstalling the agent would be more complex for a preference pane that was installed globally for all users. Apple is eagerly deprecating privilege escalation mechanism left and right, leaving the half-baked `SMJobBless` and the rudimentary `authopen`. I'm not saying it couldn't be done, I'm just not convinced it'd be worth the effort.

<a id="Running.applications.are.not.affected"></a>
### Why aren't running applications affected?
Say, you have a shell session running in the Terminal application. You might wonder why changes to the environment made with EnvPane don't show up in the shell's environment.  The answer to this question lies in Unix' process model.  When a process is forked, it inherits a copy of the environment from its parent process.  The copy is independent, so changes in the parent aren't visible in the child and vice versa.  Doing anything else would undoubtedly fling open Pandora's box of concurrency. 

Applications launched via Finder are in fact forked by the per-user instance of `launchd`, and thus inherit their environment from it.  EnvPane uses `launchd`'s API to modify the environment of the user's `launchd` instance which will then pass a copy of its modified environment to subsequently launched applications.  The environment of running applications has already been copied and will _not_ be affected.

For applications other than Terminal the only workaround is to restart the application. In Terminal, you can update the shell's environment by running 

	eval `launchctl export`

This will update the shell's environment, not Terminal's. Terminal's environment is still unchanged and will be passed on to each new shell window or tab. This means you will have to run the above command in each subsequently opened Terminal tab or window. Ultimately it might be better to just restart Terminal.

License
-------

    Copyright 2012 Hannes Schmidt
    
    Licensed under the Apache License, Version 2.0 (the "License"); 
    you may not use this file except in compliance with the License. 
    You may obtain a copy of the License at 
    
    http://www.apache.org/licenses/LICENSE-2.0
    
    Unless required by applicable law or agreed to in writing, software 
    distributed under the License is distributed on an "AS IS" BASIS, 
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  
    See the License for the specific language governing permissions and
    limitations under the License.


Copyright Notices
-----------------

### Green Leaf icon by Bruno Maia

    Copyright 2008 IconTexto
    http://www.icontexto.com
    Released under CC License Attribution-Noncommercial 3.0
    http://creativecommons.org/licenses/by-nc/3.0/


### Launchd by Apple Computer, Inc.

    Copyright (c) 2005 Apple Computer, Inc. All rights reserved.


### Discount by David Loren Parsons

    This product includes software developed by
    David Loren Parsons <http://www.pell.portland.or.us/~orc>