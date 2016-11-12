#!/usr/bin/env ruby
# coding: utf-8

require 'logger'

class TestLog
  LOGLEVEL = {}
  LOGLEVEL[Logger::UNKNOWN] = 'UNKNOWN'
  LOGLEVEL[Logger::FATAL]   = 'FATAL'
  LOGLEVEL[Logger::ERROR]   = 'ERROR'
  LOGLEVEL[Logger::WARN]    = 'WARNING'
  LOGLEVEL[Logger::INFO]    = 'INFORMATION'
  LOGLEVEL[Logger::DEBUG]   = 'DEBUG'

  def initialize(logfile = '/tmp/log')
    @log = Logger.new(logfile)
  end

  def PutLog(loglevel)
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
end
