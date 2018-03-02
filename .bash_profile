for file in ~/.{path,bash_prompt,bashrc,exports,aliases,functions}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;

unset file;
