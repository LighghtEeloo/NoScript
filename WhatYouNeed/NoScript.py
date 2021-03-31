text_script = "scripts.md"
elm_script = "InevitableVillainy.elm"



def to_elm(md_name: str, elm_name: str):
    """
    decodes scripts.md and encodes it to InevitableVillainy.elm
    """

    def article_parse(lines: list[str]):
        """
        parse to titles and chapters, ignores lines starting with ";"
        """
        lines = list(filter(lambda x: x[0]!=";", lines))
        title_group = []
        # a list of lined chapter, identical with title_group in len()
        chapter_group = []

        # chapter: list[str] -> lined: str
        def concat(chapter):
            lined = ""
            for line in chapter:
                lined += line
            return lined

        # get all '@' started lines, and get titles and chapters
        last = -1 # -1 if not recording; head if recording
        for i in range(len(lines)):
            if lines[i][0] == '@':
                if last < 0:
                    title_group.append(lines[i][2:-1])
                    last = i
                else:
                    chapter_group.append(concat(lines[last+1:i]))
                    last = -1
        
        return title_group, chapter_group

    def chapter_parse(lined: str):

        def decoder(lined: str):
            """
            decodes the whole article by '- 's and greedy '\n's; 
            """
            lines: list[str]
            lines = list(filter(lambda x: x!="", lined.split('- ')))
            def strip_new_line(line: str):
                if line[-1] == "\n":
                    line = line[:-1]
                return line
            for i in range(len(lines)):
                lines[i] = strip_new_line(lines[i])
            return lines
            
        print(f"---Here: \n{lined}\n---\n")
        lines = decoder(lined)
        print(f"---There: \n{lines}\n---\n")

        def encoder(lines: list[str]):
            '''
            encodes list to "[ """a""", """b""", """c""" ]"
            '''
            return "[ " + ", ".join(
                list(map(
                    lambda x: "\"\"\"" + x + "\"\"\"", 
                    lines
                ))
            ) + " ]"

        return encoder(lines)

    def compose(title: str, chapter: str):
        return f"(\"{title}\", {chapter})"


    with open(md_name, 'r') as md:
        article = md.readlines()

    titles, chapters = article_parse(article)

    if len(titles) != len(chapters):
        raise "Parse Error: titles and chapters aren't properly aligned."

    code = [compose(title, chapter_parse(chapter)) for (title, chapter) in zip(titles, chapters)]
    code = ", ".join(code)
    code = "[ " + code + " ]"

    with open(elm_name, 'w') as elm:
        elm.write(
"""module InevitableVillainy exposing (..)

import Dict exposing (Dict)


type alias ScriptData =
    Dict String (List String)


scriptData : ScriptData
scriptData = 
    Dict.fromList """
        )
        elm.write(code)



# def to_md(elm_name: str, md_name: str):
#     with open(elm_name, 'r') as elm:
#         ...
#     with open(md_name, 'w') as md:
#         ...

if __name__ == '__main__':
    to_elm(text_script, elm_script)
