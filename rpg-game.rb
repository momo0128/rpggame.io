###########################################################
# rpg-game.rb

# Description: コインをためながら敵の討伐を目指すRPGゲームです！
############################################################







$myweapon = {"剣" => 0, "弓" => 0, "ハンマー" => 0, "魔法の杖" => 0}
$money = 0
$character_mp = 300
$character_power=1000
$scene
class Stage
  def stage(regen_power, weapon, _level)
    # ターン数
    n = 0
    # 武器の攻撃力
    while true
      #選択肢の案内表示
      sleep 1
      puts ""
      puts "バトルスタート!"
      puts ""
      sleep 1
      puts "攻撃方法を選んでください"
      puts "１．集中攻撃"
      puts "２．連続攻撃"
      puts "３．攻撃"
      puts "４．一回休む"
      puts "５．体力回復"

      # キャラクターの攻撃力
      c_power=0
      # 敵の攻撃力
      r_power=0
      input_value = gets.to_i
      
      # １．集中攻撃を選んだ場合
      if input_value == 1
        if $character_mp - 100 >= 0
          if wea = weapon[0]
            c_power += rand(500..1500) 
            r_power += rand (250..280)
          elsif wea = weapon[1]
            c_power += rand(500..1500) 
            r_power += rand (250..280)
          elsif wea = weapon[2]
            c_power += rand(500..1500) 
            r_power += rand (250..280)
          else
            c_power += rand(500..1500) 
            r_power += rand (250..280)
          end
          $character_mp -= 100
          puts '集中攻撃が行われた！'
          
        else
          puts 'MPが足りません'
        end
        
      # ２．連続攻撃を選んだ場合
      elsif input_value == 2
        if $character_mp - 60 >= 0
          if wea = weapon[0]
            c_power += rand(150..450) 
            r_power += rand(250..280)
          elsif wea = weapon[1]
            c_power += rand(150..450) 
            r_power += rand(250..280)
          elsif wea = weapon[2]
            c_power += rand(150..450)
            r_power += rand(250..280)
          else
            c_power += rand(150..450)
            r_power += rand(250..280)
          end
          $character_mp -= 60
          puts '連続攻撃が行われた！'
        else
          puts 'MPが足りません'
        end
        
      # ３．攻撃を選んだ場合1
      elsif input_value == 3
        if $character_mp - 40 >= 0
          c_power += rand(80..170)
          r_power += rand(250..280)
          $character_mp -= 40
          $character_power += 250
          puts '攻撃が行われた!'
        else
          puts 'MPが足りません'
        end
        
      # 5.体力回復を選んだ場合
      elsif input_value == 5
        if $character_mp - 20 >= 0
          r_power += rand(100..200)
          $character_power += 400
          $character_mp -= 20
          puts '体力を400回復した'
        else
          puts 'MPが足りません'
        end
        
      # 4.一回休むもしくはそれ以外の文字を入力した場合
      else
        r_power = rand(250..280)
        puts '攻撃を1回休んだ'
      end

      # キャラクターの体力の減少
      regen_power -= c_power
      $character_power -= r_power
      $character_mp += 30
      
      regen_power = 0 if regen_power < 0
      
      $character_power = 0 if $character_power < 0
      
      $character_mp = 0 if $character_mp < 0

      # 各体力に関する表示
      puts "レイガンの体力が#{regen_power}になった！"
      sleep 1
      if regen_power > 0
        puts 'レイガンの攻撃を食らった！'
        sleep 1
        puts "あなたの体力が#{$character_power}になった"
        sleep 1
        puts "あなたのMPが#{$character_mp}になった"
        puts ''
      end

      # 勝敗
      if regen_power == 0
        puts '勝利!!'
        gets_money = rand(1000..1800)
        $money += gets_money
        puts "#{gets_money}コイン獲得しました。"
        sleep 2
        $scene = 'choice'
        break
      elsif $character_power == 0
        puts '敗北・・・'
        sleep 2
        $money += 50
        puts '50コイン獲得しました。'
        $scene = 'lose_choice'
        break
      end

      n += 1
      puts "#{n}ターン"
    end
  end
end

## Stage1終了 ##




class Gacha
  # ガチャのメソッド
  # level: 武器のレベル
  # wea: 武器の種類
  # money: 所持金
  # n:回す回数
  # levelとweaを組み合わせたものを表示する

  def gacha
    weapon = %w[剣 弓 魔法の杖 ハンマー]
    level = %w[ぽんこつな ふつうの 使える すごい 有名な 伝説の]
    puts ""
    puts "あなたの所持金は#{$money}コインです。"
    puts '何回回しますか？'
    puts '1回300コインで回すことができます。'
    puts '一度に10回まで回すことができます。'
    n = gets.to_i
    if n <= 10 && $money - 300 >= 0
      puts 'ガチャ START!!'
      sleep 1
      puts '3'
      sleep 1
      puts '2'
      sleep 1
      puts '1'
      sleep 1
    end
    num = 1
    
    while num <= n
      if n > 10
        puts '１０回より多く回すことはできません。'
        break
      elsif $money - 300 >= 0
        # レベルによって排出量が違う
        ran = rand(max = 100)
        if ran == 99
          @lv = level[5]
          power = 5
        elsif ran >= 94
          @lv = level[4]
          power = 4
        elsif ran >= 84
          @lv = level[3]
          power = 3
        elsif ran >= 64
          @lv = level[2]
          power = 2
        elsif ran >= 34
          @lv = level[1]
          power = 1
        else
          @lv = level[0]
          power = 0.5
        end
        wea = weapon.sample
        puts '-------------------------------'
        print @lv
        print wea
        print "GET!!\n"
        puts '-------------------------------'
        sleep 1
        num += 1
        $money -= 300
        $myweapon.store(wea, power)
      else
        puts '所持金が足りません'
        break
      end
    end
    
    puts "あなたの所持金は#{$money}コインです"
    $money
  end
  
  def level 
    @lv
  end
end





## ここから実行部分 ##
class Supermain
  $scene = 'opening'
  while true
    case $scene
    when 'opening'
      sleep 1
      puts 'あなたは魔王を討伐するため世界を旅することにしました。'
      sleep 1
      puts '武器を使い、敵を討伐しましょう！'
      
      sleep 2
      puts '準備はいいですか？'
      
      sleep 1
      puts 'ゲームSTART！'
      
      # 初めの敵
      
      sleep 1
      puts '早速モンスターに出会いました！'
      sleep 1
      puts '-----------------------------------------------'
      puts 'HP:100 '
      puts '-----------------------------------------------'
      
      puts '敵に遭遇した'
      sleep 1
      puts '1:戦う? 2:逃げる？'
      choice = gets.to_i
      sleep 1
      # 逃げるを選択しても1/10の確率でしか逃げられない
      if choice == 2
        kakuritsu = rand(1..10)
        if kakuritsu == 10
          puts '運よく逃げれた！'
          sleep 1
          kane = rand(1..1000)
          puts "あ、#{kane}コイン拾った"
          $money += kane
          $scene = 'stage2'
        else
          puts '先回りされた！運がない・・・。'
          sleep 1
          puts '戦うしかない・・・！'
        end
      elsif choice == 1
        puts 'よし、勇気を出して戦おう！'
      else
        puts 'もうどうしたら良いかわからないけど戦うしかない！'
      end
      $scene = 'start_gacha'
      
    when 'start_gacha'
      sleep 1
      puts '初めに使う武器をガチャで決めるよ！'
      sleep 1
      puts '今回は初回報酬として300コインプレゼント！'
      $money = 300
      sleep 1
      puts 'ガチャの回数は1回を選択してね！'
      sleep 1
      g = Gacha.new
      g.gacha
      $scene = 'stage1'
      
    when 'stage1'
      # 武器の代入 
      print $myweapon[0]
      sta = Stage.new
      sta.stage(1000, $myweapon, g.level)

      # 次の行動を選択
      puts "次のボスに挑む前にミニゲームかガチャをひきませんか？"
      sleep 1
      puts "１．何もせずに次のボスに挑む"
      puts "２．ミニゲーム"
      puts "３．ガチャをひく"
      choice = gets.to_i
      if choice == 2
        $scene = 'minigame'
      elsif choice == 3
        g1 = Gacha.new
        g1.gacha
        $scene = 'stage2'
      else
        $scene = 'stage2'
      end
      
      when 'stage2'
        puts "次のボスが表れた!"
        sta = Stage.new
        if choice == 3
          sta.stage(10000, $myweapon, g1.level)
        else
            sta.stage(1000, $myweapon, g.level)
        end
        
      print '物語はまだ続く'
      sleep 1
      print '・・・かもしれん'

      exit
      
      
    ## ストーリーはここで終了 ##
      
      

      
    # ミニゲーム
    # ミニゲームで正解した数×100コイン獲得することができます。
    when 'minigame'
      seikai = 0
      puts '次のうち魚ではない生き物は？'
      puts '1. サメ 2. シャチ 3. エイ'
      input = gets.to_i
      answer = 2
      if input == answer
        puts '正解です！'
        seikai += 1
        puts "正解数:#{seikai}"
      else
        puts '不正解です。'
        puts "正解数:#{seikai}"
      end
      
        puts 'エジプトの首都は？'
        puts '1. Cairo 2. Nairobi 3. Beijing'
        input2 = gets.to_i
        answer2 = 1
        if input2 == answer2
          puts '正解です！'
          seikai += 1
          puts "正解数:#{seikai}"
          puts
        else
          puts '不正解です。'
          puts "正解数:#{seikai}"
        end
      
        puts '31日がない月は？'
        puts '1. 7月 2. 8月 3. 9月'
        input3 = gets.to_i
        answer3 = 3
        if input3 == answer3
          puts '正解です！'
          seikai += 1
          puts "正解数:#{seikai}"
        else
          puts '不正解です。'
          puts "正解数:#{seikai}"
      end
      
        puts 'いちごのつぶつぶは、次のうち何になるでしょうか？'
        puts '1. 果実 2. 種 3. 花'
        input4 = gets.to_i
        answer4 = 1
        if input4 == answer4
          puts '正解です！'
          seikai += 1
          puts "正解数:#{seikai}"
        else
      puts '不正解です。'
      puts "正解数:#{seikai}"
        end
        
        puts '次のうち一番古いテレビアニメはどれでしょうか？'
        puts '1. 名探偵コナン 2. クレヨンしんちゃん 3. 忍たま乱太郎'
        input5 = gets.to_i
        answer5 = 2
        if input5 == answer5
          puts '正解です！'
          seikai += 1
          puts "正解数:#{seikai}"
        else
          puts '不正解です。'
          puts "正解数:#{seikai}"
        end
        
        puts "あなたの獲得したコインは#{seikai *100}です！"
        
        $scene = 'stage2'
    end
  end
end





# データ保存

class Save
  require 'csv'
  def save
    CSV.open('mywepon.csv', 'w') do |f|
      f << $myweapon
    end
    CSV.open('money.csv', 'w') do |m|
      m << [$money]
    end
    CSV.open('scene.csv', 'w') do |f|
      f << scene
    end
  end
end

class Load
  require 'csv'
  def load
    CSV.read('mywepon.csv').each do |weeee|
      weeee.each do |w1|
        $myweapon.push w1
      end
    end
    $money = CSV.read('money.csv')[0][0].to_i
  end
end

class Main
  def main
    ld = Load.new
    ld.load
    while true
      puts '1 gacha 0 quit'
      koudou = gets.to_i
      if koudou == 1
        g = Gacha.new
        g.gacha
      elsif koudou == 0
        saver = Save.new
        saver.save
        break
      end
    end
  end
end

m = Supermain.new

