> story_log.txt

dialog --title "以下常見的五種貓咪品種" --msgbox "\n 1.波斯貓\n 2.英國短毛貓\n 3.布偶貓\n 4.蘇格蘭摺耳貓\n 5.緬因貓" 10 35;

catvariety=$(dialog --stdout --menu "請選擇您想領養的貓咪品種" 13 30 5 \
    1 "波斯貓" \
    2 "英國短毛貓" \
    3 "布偶貓" \
    4 "蘇格蘭摺耳貓" \
    5 "緬因貓")

catname=$(dialog --stdout --inputbox "為您剛剛領養的貓咪取個名字吧!" 8 40)

case $catvariety in
    1) variety="波斯貓";;
    2) variety="英國短毛貓";;
    3) variety="布偶貓";;
    4) variety="蘇格蘭摺耳貓";;
    5) variety="緬因貓";;
    *) variety="未知品種";;
esac

echo "您領養的貓咪品種為：$variety" > catthing.txt
echo "您為貓咪取的名字為：$catname" >> catthing.txt

dialog --title "請確認您的選擇" --textbox catthing.txt 8 50

dialog --yesno "故事即將啟程，請問是否繼續?" 5 40
if [ $? -eq 0 ]; then
    story="您領養的$variety $catname，即將開始冒險之旅!\n
在一個安憂的小鎮裡，$catname 是隻外表可愛、樂於助人的貓咪。\n
時常幫助路上的奶奶貓和爺爺貓，也會主動照料小幼貓。\n
某天在昏暗的巷道中，發現一張神秘的地圖，似乎藏著一個關於人類王國的秘密...\n
$catname 決定展開這奇妙的冒險!!"

    dialog --title "您的貓咪冒險故事" --msgbox "$story" 15 50
else
    dialog --msgbox "下次再來~" 5 30
    exit
fi

dialog --title "您的貓咪冒險故事" --msgbox "$catname 決定隔天一早就出發!\n剛走出貓王國的城門，就遇到了正在堅守崗位的 橘貓騎士，\n橘貓騎士 詢問:今天要去哪呀?\n$catname 回答:要去探索人類王國，去尋找自己的主人!\n橘貓騎士 說:要小心!不要隨便就被肉泥拐走了唷~\n$catname : 知道了!!我出發了唷~" 15 60

rode_choice=$(dialog --stdout --menu "走了不久遇到一條岔路，請選擇道路:" 10 50 2 \
    "A" "雜草叢生的路" \
    "B" "小花小草的路")

if [ "$rode_choice" = "A" ]; then
    echo "$catname 選擇了雜草叢生的道路。" >> story_log.txt
    dialog --msgbox "$catname 在路上發現一隻受傷的小精靈，\n小精靈正在尋求協助。" 10 50

    result_choice=$(dialog --stdout --menu "是否幫助小精靈?" 10 50 2 \
        "Yes" "幫助小精靈" \
        "No" "不幫助，狠心離開")

    if [ "$result_choice" = "Yes" ]; then
        echo "$catname 幫助了小精靈，再次認證是隻樂於助人的小貓。" >> story_log.txt
    else
        echo "$catname 冷漠地離開，被遣返回貓咪王國。" >> story_log.txt
        dialog --msgbox "$catname 違背自己的良心，遭受遣返!!" 10 50
        dialog --textbox story_log.txt 15 60
        exit
    fi

elif [ "$rode_choice" = "B" ]; then
    echo "$catname 選擇了小花小草的道路，來到了歡樂的小鎮。" >> story_log.txt
    dialog --msgbox "小鎮裡有許多友善可愛的動物，\n大家聚在一起聊天玩耍。" 10 50

    result_choice=$(dialog --stdout --menu "是否繼續往前探索?" 10 50 2 \
        "Yes" "繼續踏上尋找之路!" \
        "No" "不~想留在這裡。")

    if [ "$result_choice" = "Yes" ]; then
        echo "$catname 繼續探索。" >> story_log.txt
    else
        echo "$catname 留在歡樂小鎮，但因為住宿都滿了，只能原路返回貓咪王國。" >> story_log.txt
        dialog --textbox story_log.txt 15 60
        exit
    fi
fi

human=$(dialog --stdout --menu "遇到了兩種人類，請選擇:" 10 50 2 \
    "Right" "全身穿著風衣，包緊緊，面帶微笑的人" \
    "Left" "面色莊嚴，穿著長袍的人")

if [ "$human" = "Right" ]; then
    echo "$catname 遇到了壞人!!試圖欺負可愛的貓咪..." >> story_log.txt
    dialog --msgbox "壞人欺負 $catname ，這趟冒險就此畫下句點。" 10 50
    dialog --textbox story_log.txt 15 60
    exit
else
    echo "$catname 遇到了好心人，幫助 $catname 治療，並給予溫暖的家。" >> story_log.txt
fi

dialog --msgbox "經過這段奇妙的旅程，$catname 終於找到了自己的主人。\n充滿著挑戰與驚喜，謝謝你的選擇!" 10 50
dialog --textbox story_log.txt 15 60
