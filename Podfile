platform :ios, '13.0'
inhibit_all_warnings!
pod 'SwiftSocket', '2.0.2'

workspace 'Project/HelloWorld/Exider.org.xcodeproj'

pre_install do |installer|
    installer.analysis_result.specifications.each do |s|
        if s.name == 'SwiftSocket'
            s.swift_version = '4.2'
        end
    end
end