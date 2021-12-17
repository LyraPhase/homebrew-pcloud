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
  version "3.10.7"

  if Hardware::CPU.intel?
    sha256 "ce8054a38dfb8e2ba49dd2bc4028e4b8f752696f1cf87b18aa471cbd030c7bab"

    pkg "pCloud Drive #{version.to_s}.pkg"

    code = "XZrW1UXZ3zQ5i4lMyGHnB6dsDOi1dhBbP957"
  else
    sha256 "a2efdd7000808030f0dc0b55d3b0b8fc5d52c17b3d388e66558930eddd3dce09"

    pkg "pCloud Drive #{version.to_s} M1.pkg"

    code = "XZEdLOXZjOLRegUXXXbfuFTfjxBwk8kPiNcX"
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
