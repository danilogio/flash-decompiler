[Ludicast](http://ludicast.com) is starting here a project for decompiling flash documents.  We have 4 milestones:

  1. The generation of ASDocs based on filtered categories.
  1. The decompilation of SWFs previous to Flash 9.
  1. The decompilation of Flash 9 SWFs.  This will include a parser for the abc intermediate bytecode language.
  1. An obfuscator based on the previous steps.

Basically, since every swf in the wild is decompilable (Adobe: this means Buzzword & Photoshop Express), and Intellectual Property is the lifeblood of most startups, we are doing this project to help the Flash community, not hurt it.

One key aspect of this project is that it is written as a Flex/AIR project, making it easy for those who benefit from it to contribute.

We feel that the sooner we have a working decompiler released, the sooner we will be able to provide a working obfuscator.  Plus a working decompiler will alert developers of the risks inherent in publishing their SWFs prematurely.  This will allow them to better gameplan their release schedule.

Any questions, feel free to email [Nate Kidwell](mailto:nate@ludicast.com).

Some obvious projects we are drawing inspiration and sources from are: [swfassist](http://swfassist.libspark.org/), [tamarin](http://www.mozilla.org/projects/tamarin/), [hurlant's decompiler](http://eval.hurlant.com/).  If anybody knows of any other relevant projects, let us know.

Feel free to use this decompiler in any of your projects.  If you want to contribute, there are three key ways:
  1. Pick a tag in the tags directory and start coding.  Each tag describes a bit of flash functionality, such as actionscript, font infomation, embedded images and so forth.  Something probably matches with your skillset
  1. Instrument the embedded webkit webbrowser to have a swfcatcher-like interface making it easier to capture swfs with a single click.  This would require a bit of javascript magic.
  1. Research other projects such as swfassist for code that can be used.