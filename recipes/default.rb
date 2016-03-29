#
# Cookbook Name:: apache
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

include_recipe 'apache::pre_installation'
#include_recipe 'apache::file'
include_recipe 'apache::post_ins'
include_recipe 'apache::configration'
