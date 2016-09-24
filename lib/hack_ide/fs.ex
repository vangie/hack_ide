defmodule HackIde.FileSystem.File do
  defstruct name: "", mode: "-rw-rw-r--", size: "1k", content: ""

  @type t :: %__MODULE__{name: String.t, mode: String.t, size: String.t, content: String.t }
end

defmodule HackIde.FileSystem.Folder do
  defstruct name: "", mode: "drwxrwxr-x", size: "4096", content: []

  alias HackIde.FileSystem.File

  @type t :: %__MODULE__{name: String.t, mode: String.t, size: String.t, content: [ __MODULE__.t | File.t ] }
end

defmodule HackIde.FileSystem do
  alias HackIde.FileSystem.File
  alias HackIde.FileSystem.Folder
  alias HackIde.Fiction

  @current %Folder{name: "."}
  @parent %Folder{name: ".."}

  @default_root %Folder{content: [
    %Folder{name: "bin"},
    %Folder{name: "boot"},
    %Folder{name: "dev"},
    %Folder{name: "etc"},
    %Folder{name: "home"},
    %Folder{name: "lib"},
    %Folder{name: "media"},
    %Folder{name: "mnt"},
    %Folder{name: "opt"},
    %Folder{name: "root"},
    %Folder{name: "sbin"},
    %Folder{name: "srv"},
    %Folder{name: "tmp"},
    %Folder{name: "usr", content: [
      %Folder{name: "bin"},
      %Folder{name: "include"},
      %Folder{name: "lib"},
      %Folder{name: "sbin"}
    ]},
    %Folder{name: "var", content: [
      %Folder{name: "cache"},
      %Folder{name: "log"},
      %Folder{name: "spool"},
      %Folder{name: "tmp"}
    ]}
  ]}


  def root(:localhost) do
    _add(@default_root, "/root", %File{name: "readme", content: """
    很高兴你能接受这个委托。现在的情况非常紧急，我们急需那份神秘源码。找到它，我知道这很困难，但现在只有你能帮我了，必要的工具已经安装到了你的本地系统，输入 jump 就能运行。

    你的委托人

    I'm glad you can accept this commission. We are in a very urgent situation now, we need get the mysterious source code. I know it's not easy, but now only you can help me, the necessary tools have been installed to your local system, you need to type "jump" to start it.

    Your Employer
    """
    })
  end

  def root(:jumper) do
    _add(@default_root, "/root", %File{name: "tip", content: """
    你需要一个用户名和密码来登入他们的 gateway 系统，所以我希望你可以找出 wangziying 的密码。 不是我说啥，她用的密码弱爆了，对一个你这样的黑客来说简直小菜一碟。

    You need a user name and password to log into their gateway system, so I hope you can find wangziying’s password. Hacking her password is easy, it’s a piece of cake for hackers like you.
    """
    })
  end

  def root(:azurewind) do
    _add(@default_root, "/root", %File{name: "fd2.txt", content: Fiction.chapter(2)})
  end

  def root(:gateway) do
    _add(@default_root, "/root/2af96c2a-000a-4dad-a061-5645eaa4c152", %File{name: "cheat_sheet.txt", content: """
    ls                            # lists your files
    ls -l                         # lists your files in 'long format', which contains the exact size of the file, who owns the file and who has the right to look at it, and when it was last modified
    ls -a                         # lists all files, including hidden files
    ln -s <filename> <link>       # creates symbolic link to file
    touch <filename>              # creates or updates your file
    cat > <filename>              # places standard input into file
    more <filename>               # shows the first part of a file (move with space and type q to quit)
    head <filename>               # outputs the first 10 lines of file
    tail <filename>               # outputs the last 10 lines of file (useful with -f option)
    emacs <filename>              # lets you create and edit a file
    mv <filename1> <filename2>    # moves a file
    cp <filename1> <filename2>    # copies a file
    rm <filename>                 # removes a file
    diff <filename1> <filename2>  # compares files, and shows where they differ
    wc <filename>                 # tells you how many lines, words and characters there are in a file
    chmod -options <filename>     # lets you change the read, write, and execute permissions on your files
    gzip <filename>               # compresses files
    gunzip <filename>             # uncompresses files compressed by gzip
    unzip -P coding.net <filename># uncompresses files compressed by unzip
    gzcat <filename>              # lets you look at gzipped file without actually having to gunzip it
    lpr <filename>                # print the file
    lpq                           # check out the printer queue
    lprm <jobnumber>              # remove something from the printer queue
    genscript                     # converts plain text files into postscript for printing and gives you some options for formatting
    dvips <filename>              # print .dvi files (i.e. files produced by LaTeX)
    grep <pattern> <filenames>    # looks for the string in the files
    grep -r <pattern> <dir>       # search recursively for pattern in directory
    """})
  end

  def root(:hulufei) do
    _add(@default_root, "/root", %File{name: "todo.md", content: """
    1. quick login
      ```
      #!/bin/bash
      echo "java`echo 2^10|bc`" | login tanhe123
      ```
    2. drop upload file
      drop a file on textarea, then generate url like 'http://coding.com/asdasda/1f2d6857-3229-43c2-af14-70fb8f530496'
    """})
  end

  def root(:tiangao) do
    _add(@default_root, "/var/log", %File{name: "login.log", content: """
    username: xm1994,   password: 0"flesymkcah">:#,_@
    username: mingshun, password: **fu*ge
    username: hulufei,  password: *e**nge
    """})
  end


  def root(:tanhe123) do
    _add(@default_root, "/var/log", %File{name: "login.log", content: """
    username: mingshun, password: ********
    username: hulufei,  password: ********
    username: hacka
    """})
  end

  def root(:xm1994) do
    _add(@default_root, "/var/log", %File{name: "login.log", content: """
    ckape, password: D'`r#9"!IY4z8yC5.3tb0/;']%I)jF3f1eAR?wv<)([wvo5Vrkjong-,Miha'_G]b[Z~^W\\[ZYRvVUT6Lp]
    username: mingshun, password: mal*****
    username: hulufei,  password: ****olge
    """})
  end

  def root(:duwan) do
    _add(@default_root, "/coding.net/s", %File{name: "83bacece-65b6-4dae-b0ef-2d266454765d", content: """
    现招募大批小猴子！壮大队伍，一起走向 Global !
    表再犹豫，下面的职位总有一款适合你！
    那就给我 duwan@coding.net 发个简历呗！
    https://coding.net/jobs

    The monkey army is recruting!
    Send your resume to  duwan@coding.net 
    Checkout available positions at:
    https://coding.net/jobs
    """
    })
  end

  def root(_) do
    @default_root
  end

  def cat(root, path, pwd) do
    Path.expand(path, pwd)
    |> locate(root)
    |> _cat
  end

  def ls(root, path, pwd) do
    Path.expand(path, pwd)
    |> locate(root)
    |> _ls
  end

  def expand(path, pwd) do
    Path.expand(path, pwd)
  end

  defp _add(%Folder{}=folder, path, file) do
    pathList = path |> String.split("/") |> List.delete_at(0)
    __add(folder, pathList, file)
  end

  defp __add(%Folder{}=folder, [""], file) do
    __add(%Folder{}=folder, [], file)
  end

  defp __add(%Folder{}=folder, [head | tail], file) do
    case Enum.find_index(folder.content, &(&1.name == head)) do
      nil ->
        %Folder{ folder | content: folder.content ++ [__add(%Folder{name: head}, tail, file)]}
      idx ->
        current = Enum.at(folder.content, idx)
        %Folder{ folder | content: List.replace_at(folder.content, idx, __add(current, tail, file))}
    end
  end

  defp __add(%Folder{}=folder, [], file) do
    case Enum.find_index(folder.content, &(&1.name == file.name)) do
      nil -> %Folder{ folder | content: folder.content ++ [file]}
      idx -> %Folder{ folder | content: List.replace_at(folder.content, idx, file)}
    end
  end

  defp _cat(%Folder{} = f) do
    _ls f
  end

  defp _cat(%File{} = f) do
    f.content
  end

  defp _cat(:not_found) do
    "No such file or directory\n"
  end

  defp _ls(%Folder{} = folder) do
    (for f <- [@current, @parent] ++ folder.content, do: _puts f)
    |> Enum.join("")
  end

  defp _ls(%File{} = f) do
    _puts f
  end

  defp _ls(:not_found) do
    "No such file or directory\n"
  end

  defp _puts(%Folder{} = f) do
    "#{f.mode}\t#{f.size}\t#{f.name}/\n"
  end

  defp _puts(%File{} = f) do
    "#{f.mode}\t#{f.size}\t#{f.name}\n"
  end

  def locate(path, root) when is_binary(path) do
    path
    |> String.split("/")
    |> _locate(root)
  end

  defp _locate([], folder) do
    folder
  end

  defp _locate([ "" | tail], folder) do
    _locate(tail, folder)
  end

  defp _locate([name | tail], folder) do
    case Enum.find(folder.content, &(&1.name == name)) do
      nil ->
        :not_found
      _file = %File{} when tail !=[] ->
        :not_found
      folder ->
        _locate(tail, folder)
    end
  end
end
