rm -rf .generated
mkdir .generated
cd .generated
mkdir Sources
cd Sources
sdef $1 > $2.sdef
sdp -fh --basename $2 $2.sdef
python3 ../../sbhc.py $2.h
python3 ../../sbsc.py $2.sdef

cd ..

cat > Package.swift<< EOF
// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "$2",
    platforms: [.macOS(.v14)],
    products: [
        .library(
            name: "$2",
            targets: ["$2"]
        ),
    ],
    targets: [
        .target(name: "$2", path: "Sources")
    ]
)
EOF

cp -R "." "../../Frameworks/$2"