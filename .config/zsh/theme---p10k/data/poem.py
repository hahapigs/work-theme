# ~/poem.py

import os

# 古诗列表
poems = [
    "孤帆远影碧空尽，唯见长江天际流",
    "借问酒家何处有，牧童遥指杏花村",
    "国破山河在，城春草木深",
    "好雨知时节，当春乃发生",
    "窗含西岭千秋雪，门泊东吴万里船",
    "千山鸟飞绝，万径人踪灭",
    "独在异乡为异客，每逢佳节倍思亲",
    "夕阳无限好，只是近黄昏",
    "我问青山何日老，青山问我及时闲",
    "春蚕到死丝方尽，蜡炬成灰泪始干",
    "黄鹤一去不复返，白云千载空悠悠",
    "少小离家老大回，乡音未改鬓毛衰",
    "东边日出西边雨，道是无情却有晴",
    "举杯邀明月，对影成三人",
    "月出惊山鸟，时鸣春涧中",
    "大漠孤烟直，长河落日圆",
    "我见众山皆草木，唯有见你是青山",
    "一生如牛不得闲，闲时已与山共眠",
]

# 配置文件目录
zsh_conf_home = os.environ.get("ZSH_CONF_HOME", os.path.expanduser("~/.config/zsh"))

# 计数器文件路径
counter_file = os.path.join(zsh_conf_home, "theme---p10k", "data", ".poem_counter")

def get_poem():
    # 读取计数器
    if os.path.exists(counter_file):
        with open(counter_file, "r") as f:
            counter = int(f.read().strip())
    else:
        counter = 0

    # 获取当前古诗
    poem = poems[counter]

    # 更新计数器
    counter = (counter + 1) % len(poems)
    with open(counter_file, "w") as f:
        f.write(str(counter))

    return poem

if __name__ == "__main__":
    print(get_poem())
