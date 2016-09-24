defmodule HackIde.Mail.Message do
  defstruct no: "1", name: "", box: "<sent>" , content: ""
end

defmodule HackIde.Mail do

  alias HackIde.Mail.Message
  alias HackIde.Fiction

  def help do
    """
    mail help menu:
      exit            exits this program.
      help            display this menu.
      ls              list mail messages.
      show [n]        show message details.
    """
  end

  def ls(host) do
    list = mailList(host)
    cond do
      Enum.count(list) == 0 ->
        "Empty.\n"
      true ->
        (for msg <- mailList(host), into: ["List of Messages\n"], do: "#{msg.no}\t#{msg.name}\t\t#{msg.box}\n")
        |> Enum.join("")
    end

  end

  def show(host, n) do
    host
    |> mailList
    |> Enum.find(%Message{content: "The message '#{n}' is not found.\n"}, &(&1.no == n))
    |> Map.get(:content)
  end

  def mailList(:wangziying) do
    [
      %Message{no: "1", name: "fd1", box: "<inbox>" ,content: Fiction.chapter(1)},
      %Message{no: "2", name: "azurewind", box: "<inbox>" ,content: """
      小说好看么？我机器上还有一个章节，喜欢的话自取。
      -.-. .- ..-. ..-. . .. -. .

      Like the story? I got another chapter on my machine, feel free to grab it.
      -.-. .- ..-. ..-. . .. -. .
      """
      }
    ]
  end

  def mailList(:azurewind) do
    [
      %Message{no: "1", name: "fd3", box: "<sent>", content: Fiction.chapter(3)},
      %Message{no: "2", name: "tiangao", box: "<sent>", content: """
      我只有1-3章，据 tanhe123 说 mingshun 那里有第四章的内容。
      另外，下片子了没，去你那里拷贝点电影？

      I only got chap 1-3, tanhe123 said mingshun has chap 4
      P.S. Got new movies? Mind if I login your host to download some?
      """
      },
      %Message{no: "3", name: "tiangao", box: "<inbox>", content: """
      非常感谢啊！另外，hackape 说他已经看完了。
      你知道我是土拨鼠的拥趸。 ;)

      Thanks for that story. hackape said he's done reading.
      You know I'm a gopher fan. ;)
      """
      },
    ]
  end

  def mailList(:tiangao) do
    [
      %Message{no: "1", name: "fd5", box: "<inbox>", content: Fiction.chapter(5)},
      %Message{no: "2", name: "xm1994", box: "<sent>", content: """
      mingshun 估计在看连续剧，你看过第四章了没有？

      mingshun is probably watching tv series. You read chapter 4 already?
      """
      },
      %Message{no: "3", name: "xm1994", box: "<inbox>", content: """
      +[----->+++<]>+.+++++++.--.--------.---.+++++++++++++.++++++++++.
      """
      },
      %Message{no: "4", name: "duwan", box: "<inbox>", content: """
      发现 login 程序偶尔会泄露用户登录密码，不过还好不是明文，呵呵。

      I found the login program sometimes leaks user's password, luckily we've encrypted them.
      """
      }
    ]
  end

  def mailList(:mingshun) do
    [
      %Message{no: "1", name: "tiangao", box: "<inbox>", content: """
      求第四章

      Mind send me chap 4?
      """
      },
      %Message{no: "2", name: "duwan", box: "<inbox>", content: """
      hulufei

      🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔
      🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔
      🐔 🐔 🐔 🐔
      🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔
      🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔
      🐔 🐔 🐔 🐔 🐔 🐔 🐔
      🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔
      🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔
      🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔
      🐔 🐔 🐔 🐔
      🐔 🐔 🐔
      🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔
      🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔
      🐔 🐔 🐔
      🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔
      🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔
      🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔
      🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔
      🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔
      🐔 🐔 🐔 🐔 🐔 🐔

      🐔 🐔 🐔
      🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔
      🐔 🐔 🐔 🐔
      🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔
      🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔
      🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔
      🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔
      🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔
      🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔
      🐔 🐔 🐔 🐔 🐔 🐔

      🐔 🐔 🐔 🐔
      🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔
      🐔 🐔
      🐔 🐔
      🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔
      🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔
      🐔 🐔 🐔 🐔 🐔 🐔

      🐔 🐔
      🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔
      🐔 🐔 🐔 🐔 🐔 🐔 🐔
      🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔
      🐔 🐔 🐔 🐔 🐔 🐔

      🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔
      🐔 🐔 🐔
      🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔
      🐔 🐔 🐔 🐔 🐔 🐔 🐔
      🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔
      🐔 🐔 🐔 🐔 🐔 🐔

      🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔
      🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔
      🐔 🐔 🐔
      🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔
      🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔 🐔
      🐔 🐔 🐔 🐔 🐔 🐔
      
      """
      },
      %Message{no: "3", name: "duwan", box: "<sent>", content: """
      哪台机器可以挂个BT？

      Which machine can be used to seed torrent?
      """
      }

    ]

  end

  def mailList(:hackape) do
    [
      %Message{no: "1", name: "fd4", box: "<inbox>" ,content: Fiction.chapter(4)},
      %Message{no: "2", name: "duwan", box: "<inbox>" ,content: """
      要不要来一块键盘掌托？

      Hey, want buy this wrist rest?

      https://dn-coding-net-production-pp.qbox.me/9afff63b-47e1-4beb-b394-afcbe60ee69b.jpeg
      """
      }
    ]
  end

  def mailList(_), do: []

end
