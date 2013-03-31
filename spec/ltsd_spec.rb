# -*- coding: utf-8 -*-

# require_relative "../ltsv.rb"
# require __dir__ + '/spec_helper'
require_relative './spec_helper'

describe LTSV do
  context "when keys are a and b" do
    describe "#[]=" do
      before do
        @ltsv = LTSV.new
        @ltsv["key_a"] = "value_a"
        @ltsv["key_b"] = "value_b"
      end

      it{ @ltsv["key_a"].should eq "value_a" }
      it{ @ltsv["key_b"].should eq "value_b" }
    end

    describe "dump" do
      before do
        @ltsv = LTSV.new
        @ltsv["key_a"] = "value_a"
        @ltsv["key_b"] = "value_b"
      end

      it{ @ltsv.dump().should eq "key_a:value_a\tkey_b:value_b"}
    end
  end

  context "when keys are c and d" do
    before do
      @ltsv = LTSV.new
      @ltsv["key_c"] = "value_c"
      @ltsv["key_d"] = "value_d"
    end

    it{ @ltsv.dump().should eq "key_c:value_c\tkey_d:value_d"}
  end

  context "同じキーが渡されると上書き" do
    before do
      @ltsv = LTSV.new
      @ltsv["key_a"] = "value_a"
      @ltsv["key_b"] = "value_b"
    end

    describe "[]=" do
      before{ @ltsv["key_a"] = "new_value_a" }
      it{ @ltsv["key_a"].should eq "new_value_a" }
      #it{ (@ltsv["key_b"] = "new_value_b").should eq "value_b"  }
      # 上記の様に書きたかった。が、だめ・・・っ
      it do
        (@ltsv.set("key_b", "new_value_b")).should eq "value_b"
      end
    end
  end

  context "更新した順にdumpされる" do
    before do
      @ltsv = LTSV.new
      @ltsv["key_a"] = "value_a"
      @ltsv["key_b"] = "value_b"
    end

    describe "[]=" do
      before{ @ltsv["key_a"] = "new_value_a" }
      it{ @ltsv.dump().should eq "key_b:value_b\tkey_a:new_value_a"}
    end
  end

  context "null,空白がキーとして渡された時" do
    before { @ltsv = LTSV.new }

    it do
      proc{ @ltsv[nil] = "any_value" }.should raise_error(ArgumentError)
    end

    it do
      proc{ @ltsv[""] = "any_value" }.should raise_error(ArgumentError)
    end
  end

  context "存在しないkeyが渡された時" do
    before { @ltsv = LTSV.new }

    it do
      @ltsv["unknown_key"].should eq nil
    end
  end


  context "空文字がvalueとして渡された時" do
    before do
      @ltsv = LTSV.new
      @ltsv.set("key", "")
    end

    it do
      @ltsv["key"].should eq ""
    end
  end
end
