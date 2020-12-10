#  brew cask install font-inconsolata-go-nerd-font
#  brew cask install font-hack-nerd-font font-meslo-nerd-font font-sourcecodepro-nerd-font
#  brew install font-meslo-nerd-font

# script from https://gist.github.com/ELLIOTTCABLE/5b87ab21b11acb76a5c52d47a022b519

# Creating this because I'm *sure* I'll forget how to do this.

# 1. Customize your Input fontface, and download it from their website:
open -a Safari \
   "http://input.fontbureau.com/download/index.html?size=14&language=javascript&theme=base16-dark&family=InputMono&width=200&weight=300&line-height=1.3&a=0&g=ss&i=serif&l=serifs_round&zero=slash&asterisk=height&braces=straight&preset=dejavu&customize=please"
"https://input.fontbureau.com/download/index.html?customize&fontSelection=fourStyleFamily&regular=InputMonoNarrow-Light&italic=InputMonoNarrow-LightItalic&bold=InputMonoNarrow-Medium&boldItalic=InputMonoNarrow-MediumItalic&a=0&g=ss&i=serif&l=serifs_round&zero=slash&asterisk=height&braces=straight&preset=dejavu&line-height=1.3&email="

# 2. Download the ‘patcher script’:
# (I have no idea why the hell this script requires the `changelog.md` as well; and we [ab]use
#  GitHub's SVN bridge to download *just* the `src/glyphs`, instead of the 100s of megabytes of
#  pre-patched fonts)
cd ~/Downloads/Input-Font
curl -o nerd-patcher.py -JO -fsSl --proto-redir -all,https \
   https://raw.githubusercontent.com/ryanoasis/nerd-fonts/2.1.0/{font-patcher,changelog.md}
svn checkout https://github.com/ryanoasis/nerd-fonts/branches/2.1.0/src/glyphs src/glyphs

# 3. Install the patcher-script's dependencies:
brew install fontforge

# 4. Patch the files:
for font in Input_Fonts/Input/*.ttf; do
   #python nerd-patcher.py --careful --complete --progressbars "$font"; done
   fontforge -script ./font-patcher --careful --complete --progressbars --adjust-line-height "$font"; done

# 5. Install the patched fonts:
open -a 'Font Book' 'Input '*
