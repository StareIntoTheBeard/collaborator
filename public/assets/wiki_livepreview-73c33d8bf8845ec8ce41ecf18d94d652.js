$(document).ready(function(){function e(e){if(e.href.match(["collaborator"])||e.href.match(["localhost"])||e.href.match(["ghb"]))return!0}function t(){$(".wiki_preview a").each(function(){e(this)?(this.href.match("~~")?link=this.href.replace("~~",""):this.href.match("~")&&(link=this.href.replace("~","cate/")),this.href=link.replace(x,"")):this.href=this.href})}x=$("#titlemunch").text()+"/",btn_clicked=!1,changed=!1,$('input[type="submit"]').click(function(){btn_clicked=!0}),converter=new Markdown.Converter,$("#wiki_body").val()!=""&&($(".wiki_preview").empty().append(converter.makeHtml($("#wiki_body").val())),t()),$("#wiki_body").keyup(function(){$(".wiki_preview").empty().append(converter.makeHtml($("#wiki_body").val())),changed=!0,t()}),window.onbeforeunload=function(){if(btn_clicked==0&&changed==1)return"Don't forget to save your article!"}});