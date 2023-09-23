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
    version "3.13.4"
  elsif Hardware::CPU.physical_cpu_arm64?
    version "3.13.4"
  end

  if Hardware::CPU.intel?
    sha256 "8c41ebd7c8eb8dfa852659cd48115b72f60f70990d426b74f742b1f55200e23e"

    pkg "pCloud Drive #{version.to_s}.pkg"

    code = "XZm1CaVZQacPWT06LpS52q4k6QY1USeGXi97"
  else
    sha256 "0475b8b3fde324ce3c9f10e1fd0ecfde81605e2ea5fa72af22ae7180a4b11ac2"

    pkg "pCloud Drive #{version.to_s} macFUSE.pkg"

    code = "XZu1CaVZ9hG7ro0l4g8hUAJtqMtds8fPPHXk"
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
