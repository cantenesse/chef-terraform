node.default['terraform']['url_base'] = 'https://dl.bintray.com/mitchellh/terraform'
node.default['terraform']['version'] = '0.3.7'
node.default['terraform']['arch'] = kernel['machine'] =~ /x86_64/ ? 'amd64' : '386'

# Transform raw output of the bintray checksum list into a Hash[filename, checksum].
# https://dl.bintray.com/mitchellh/terraform/${VERSION}_SHA256SUMS?direct
node.default['terraform']['raw_checksums'] = <<-EOF
  2514928f49d3d9285e43706ffb4f3f1e63d2763fa1384fd397dbdb86a8d61e54  terraform_0.3.7_darwin_386.zip
  aecdc8119cd637e3e60967c97f9912735400814546b8e925152203fb6e99c732  terraform_0.3.7_darwin_amd64.zip
  5b80ceb8fa7a5034135234c73e090096276f4ae4289ee78afbdf8705323c974b  terraform_0.3.7_freebsd_386.zip
  6183cc4784dd6b436157a8fbbac2525cc054f64a0a666c07a1384838ccdaf101  terraform_0.3.7_freebsd_amd64.zip
  03fd50924bf629c0f91eafa754b06dbd5ef03a5d6366eb17b61a7d2829c8bf52  terraform_0.3.7_freebsd_arm.zip
  e7ef409c65439c7f1195aacb629a01dab2a6de67f79dec40093bec42d8be9d6c  terraform_0.3.7_linux_386.zip
  b63b36d76d9ea31cb6971edf23899ceb7291800618177adf987b7660b486527b  terraform_0.3.7_linux_amd64.zip
  6f636f6bc892833cbb9c54f0826841151d3295c2c6dc83caecd714b6afbcb47d  terraform_0.3.7_linux_arm.zip
  86f2f444f9ec92d363a01b0acfb062d5078191788686d5c85b621f08fad38658  terraform_0.3.7_openbsd_386.zip
  6e91575d95dd8a561602b0bba1a1debe6f8f22467385909259f86149114723dd  terraform_0.3.7_openbsd_amd64.zip
  8cdc90b3d30cfa7f9548a5d1e433cf27dfa1128a8cc828f96f8f6c59a7feac36  terraform_0.3.7_windows_386.zip
  324ff1e3e7d86b927b8b621f125932b8f12b88edbccfea484a002b2f9043685a  terraform_0.3.7_windows_amd64.zip
EOF
node.default['terraform']['checksums'] = Hash[
  node['terraform']['raw_checksums'].split("\n").map { |s| s.split.reverse }
]
filename = "terraform_#{node['terraform']['version']}_#{node['os']}_#{node['terraform']['arch']}.zip"
node.default['terraform']['checksum'] = node['terraform']['checksums'][filename]
