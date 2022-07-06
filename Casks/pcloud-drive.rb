#
# Cask:: pcloud-drive
# Recipe:: default
# Authors:: James Cuzella, Tom Gross
#
# Copyright:: © 🄯 2019-2020,  James Cuzella
# Copyright:: © 🄯 2019 Tom Gross
# License:: GPLv3.0
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.


cask "pcloud-drive" do
  if Hardware::CPU.intel?
    version "3.11.6"
  elsif Hardware::CPU.physical_cpu_arm64?
    version "3.11.6"
  end

  if Hardware::CPU.intel?
    sha256 "557c319c64fdbda0fdad871fe7a058735a9cd96742a4472cf0061c80cd5a23cb"

    pkg "pCloud Drive #{version.to_s}.pkg"

    code = "XZ5uazVZ2fso18Q3FwSGn3cyso8cVploGDmk"
  else
    sha256 "543d580d94bd9869d1c457563102132efa8db2205f1ecab98de92c5e65ff4e9d"

    pkg "pCloud Drive #{version.to_s} macFUSE.pkg"

    code = "XZ8uazVZhIfArB0E8rbWyTbLiC1d8mOubnzX"
  end

  url do
    require "net/http"
    require "json"
    api = "https://api.pcloud.com/"
    uri = URI(api + "getpublinkdownload?code=" + code)
    response = Net::HTTP.get(uri)
    data = JSON.parse(response)
    "https://" + data["hosts"][0] + data["path"]
  end

  livecheck do
    url "https://www.pcloud.com/release-notes/mac-os.html"
    strategy :page_match
    regex(%r{<b>(\d+(?:\.\d+)*)</b>}i)
  end

  name "pCloud Drive"
  homepage "https://www.pcloud.com/"
  desc "Client for the pCloud virtual cloud storage service"

  depends_on cask: "macfuse"

  uninstall quit:    "com.pcloud.pcloud.macos",
            pkgutil: "com.mobileinno.pkg.pCloudDrive"
end
