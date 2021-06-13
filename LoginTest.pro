QT += quick

CONFIG += c++17

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        httpclient.cpp \
        logintester.cpp \
        main.cpp

RESOURCES += qml.qrc
RC_ICONS = quwiappicon.ico

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

HEADERS += \
    httpclient.h \
    logintester.h




win32: LIBS += -L$$PWD/../../Qt/Tools/OpenSSL/Win_x64/lib/ -llibssl
win32: LIBS += -L$$PWD/../../Qt/Tools/OpenSSL/Win_x64/lib/ -llibcrypto

INCLUDEPATH += $$PWD/../../Qt/Tools/OpenSSL/Win_x64/include
DEPENDPATH += $$PWD/../../Qt/Tools/OpenSSL/Win_x64/include

#CONFIG(release) {
 DESTDIR = $${_PRO_FILE_PWD_}/release
 QMAKE_POST_LINK += c:/Qt/5.15.2/msvc2019_64/bin/windeployqt --compiler-runtime $$PWD/release






INCLUDEPATH += $$PWD/include
DEPENDPATH += $$PWD/include
