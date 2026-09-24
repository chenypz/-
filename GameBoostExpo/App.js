import React, { useEffect, useRef, useState } from 'react';
import { Animated, Pressable, SafeAreaView, StyleSheet, Text, View } from 'react-native';
import { StatusBar } from 'expo-status-bar';
import { Ionicons } from '@expo/vector-icons';

export default function App() {
  const [enabled, setEnabled] = useState(false);
  const pulse = useRef(new Animated.Value(0.96)).current;
  useEffect(() => {
    const loop = Animated.loop(Animated.sequence([
      Animated.timing(pulse, { toValue: 1.04, duration: 1100, useNativeDriver: true }),
      Animated.timing(pulse, { toValue: 0.96, duration: 1100, useNativeDriver: true })
    ])); loop.start(); return () => loop.stop();
  }, []);
  return <SafeAreaView style={s.safe}><StatusBar style="light" /><View style={s.container}>
    <Text style={s.kicker}>NITRO MODE</Text><Text style={s.title}>遊戲效能中心</Text>
    <View style={s.orbWrap}><Animated.View style={[s.orb, { transform: [{ scale: pulse }] }]}><Ionicons name={enabled ? 'flash' : 'power'} size={52} color="#fff" /></Animated.View></View>
    <Text style={s.status}>{enabled ? 'BOOST 已啟用' : '準備就緒'}</Text><Text style={s.sub}>{enabled ? '低干擾模式運作中' : '一鍵進入遊戲專注模式'}</Text>
    <Pressable style={s.button} onPress={() => setEnabled(v => !v)}><Ionicons name={enabled ? 'stop' : 'flash'} size={20} color="#061016" /><Text style={s.buttonText}>{enabled ? '關閉模式' : '啟動 BOOST'}</Text></Pressable>
    <View style={s.metrics}><Metric icon="thermometer" value="32°" label="裝置溫度" /><Metric icon="moon" value={enabled ? 'ON' : 'OFF'} label="專注狀態" /><Metric icon="speedometer" value="遊戲" label="模式" /></View>
    <Row icon="notifications-off" title="遊戲專注提醒" detail="開啟後可前往系統專注模式" /><Row icon="settings" title="系統設定捷徑" detail="快速檢查低耗電與顯示設定" />
    <Text style={s.credit}>製作人 CHEN</Text>
  </View></SafeAreaView>;
}
function Metric({ icon, value, label }) { return <View style={s.metric}><Ionicons name={icon} size={19} color="#55eaff" /><Text style={s.value}>{value}</Text><Text style={s.label}>{label}</Text></View>; }
function Row({ icon, title, detail }) { return <View style={s.row}><Ionicons name={icon} size={21} color="#55eaff" /><View style={{ flex: 1 }}><Text style={s.rowTitle}>{title}</Text><Text style={s.rowDetail}>{detail}</Text></View><Ionicons name="chevron-forward" size={16} color="#ffffff55" /></View>; }
const s = StyleSheet.create({ safe:{flex:1,backgroundColor:'#090b1a'},container:{flex:1,padding:22,backgroundColor:'#090b1a'},kicker:{color:'#55eaff',fontSize:12,fontWeight:'800',letterSpacing:3,marginTop:16},title:{color:'#fff',fontSize:31,fontWeight:'900',marginTop:5},orbWrap:{alignItems:'center',marginTop:26,marginBottom:16},orb:{width:152,height:152,borderRadius:76,alignItems:'center',justifyContent:'center',backgroundColor:'#6b42ff',borderWidth:2,borderColor:'#55eaff',shadowColor:'#55eaff',shadowOpacity:.7,shadowRadius:25},status:{color:'#fff',fontSize:22,fontWeight:'800',textAlign:'center'},sub:{color:'#ffffff88',textAlign:'center',marginTop:6},button:{marginTop:22,backgroundColor:'#55eaff',borderRadius:16,padding:16,flexDirection:'row',justifyContent:'center',gap:9},buttonText:{fontSize:17,fontWeight:'800',color:'#061016'},metrics:{flexDirection:'row',gap:10,marginTop:22,marginBottom:13},metric:{flex:1,padding:13,borderRadius:15,backgroundColor:'#ffffff12',gap:7},value:{color:'#fff',fontSize:18,fontWeight:'800'},label:{color:'#ffffff88',fontSize:12},row:{padding:16,borderRadius:15,backgroundColor:'#ffffff12',flexDirection:'row',alignItems:'center',gap:13,marginTop:11},rowTitle:{color:'#fff',fontWeight:'700'},rowDetail:{color:'#ffffff77',fontSize:12,marginTop:3},credit:{color:'#ffffff55',textAlign:'center',marginTop:'auto',paddingVertical:18,fontSize:12}}
