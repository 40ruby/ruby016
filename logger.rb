#!/usr/bin/env ruby
# coding: utf-8

# filename: logger.rb
require 'logger'

# ログを出力するだけのクラス
class TestLog
  LOGLEVEL = {}
  LOGLEVEL[Logger::UNKNOWN] = 'UNKNOWN'
  LOGLEVEL[Logger::FATAL]   = 'FATAL'
  LOGLEVEL[Logger::ERROR]   = 'ERROR'
  LOGLEVEL[Logger::WARN]    = 'WARNING'
  LOGLEVEL[Logger::INFO]    = 'INFORMATION'
  LOGLEVEL[Logger::DEBUG]   = 'DEBUG'

# Logger::xxxx は、DEBUG=0、UNKNOWN=5 の数値なので次のように配列でも書き換えられます
#  LOGLEVEL = ["DEBUG", "INFORMATION", "WARNING", "ERROR", "FATAL", "UNKNOWN"]

# 初期化時にログファイルを宣誓させる
  def initialize(logfile = '/tmp/log')
    @log = Logger.new(logfile)
  end

  def PutLog(loglevel)
    # Logger::level で出力するログレベルを、その都度変更できます
    @log.level = loglevel

    @log.unknown("Loglevel #{LOGLEVEL[loglevel]} の場合")
    @log.fatal('fatal')
    @log.error('error')
    @log.warn('warning')
    @log.info('infomation')
    @log.debug('debug message')
  end
end

["/tmp/log", STDOUT, STDERR].each do |out|
  puts "出力先 > #{out}"
  log = TestLog.new(out)

  [Logger::UNKNOWN, Logger::FATAL, Logger::ERROR, Logger::WARN, Logger::INFO, Logger::DEBUG].each do |lv|
    log.PutLog(lv)
  end

# 上記同様 Logger::xxxx は数字なので、次のように記述することもできます。
# 5.step(0, -1) do |lv|
# 0.step(5) でも同様の動きですが、逆順ですね
end
